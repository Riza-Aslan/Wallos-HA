<?php
/**
 * Home Assistant SSO Authentication Helper
 * 
 * Include this file at the top of index.php to enable auto-login via HA Ingress.
 */

function handleHASSO($db) {
    // Check if SSO is enabled
    if (getenv('ENABLE_SSO') !== 'true') {
        return false;
    }
    
    // Check if already logged in
    if (isset($_SESSION['loggedin']) && $_SESSION['loggedin'] === true) {
        return true;
    }
    
    // Check if request comes from HA Ingress
    // HA Ingress sets X-Ingress-Path header
    $isIngressRequest = !empty($_SERVER['HTTP_X_INGRESS_PATH']) || 
                        (!empty($_SERVER['HTTP_X_FORWARDED_FOR']) && !empty($_SERVER['HTTP_X_FORWARDED_HOST']));
    
    if (!$isIngressRequest) {
        return false;
    }
    
    // Get HA user info from Supervisor API
    $supervisorToken = getenv('SUPERVISOR_TOKEN');
    if (empty($supervisorToken)) {
        // Try to get from file
        $tokenFile = '/run/supervisor_token';
        if (file_exists($tokenFile)) {
            $supervisorToken = trim(file_get_contents($tokenFile));
        }
    }
    
    if (empty($supervisorToken)) {
        return false;
    }
    
    // Call HA Supervisor API to get current user info
    // The Supervisor API is available at http://supervisor/
    $ch = curl_init('http://supervisor/core/api/current_user');
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_HTTPHEADER, [
        'Authorization: Bearer ' . $supervisorToken,
        'Content-Type: application/json'
    ]);
    curl_setopt($ch, CURLOPT_TIMEOUT, 5);
    curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 2);
    
    $response = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    $curlError = curl_error($ch);
    curl_close($ch);
    
    if ($httpCode !== 200 || !$response) {
        error_log("SSO: Failed to get HA user info. HTTP Code: $httpCode, Error: $curlError");
        return false;
    }
    
    $haUser = json_decode($response, true);
    if (!$haUser || !isset($haUser['name'])) {
        error_log("SSO: Invalid response from HA API: " . substr($response, 0, 200));
        return false;
    }
    
    $haUsername = $haUser['name'];
    $haUserId = $haUser['id'] ?? '';
    
    // Sanitize username for Wallos
    $wallosUsername = preg_replace('/[^a-zA-Z0-9_-]/', '_', $haUsername);
    $wallosEmail = $wallosUsername . '@homeassistant.local';
    
    // Check if user exists
    $query = "SELECT id, username FROM user WHERE username = :username OR email = :email";
    $stmt = $db->prepare($query);
    $stmt->bindParam(':username', $wallosUsername, SQLITE3_TEXT);
    $stmt->bindParam(':email', $wallosEmail, SQLITE3_TEXT);
    $result = $stmt->execute();
    $user = $result->fetchArray(SQLITE3_ASSOC);
    
    if ($user) {
        // User exists, log them in
        $_SESSION['loggedin'] = true;
        $_SESSION['userId'] = $user['id'];
        $_SESSION['username'] = $user['username'];
        return true;
    }
    
    // User doesn't exist, create them
    $randomPassword = bin2hex(random_bytes(32));
    $hashedPassword = password_hash($randomPassword, PASSWORD_DEFAULT);
    $defaultCurrency = 1;
    
    $insertQuery = "INSERT INTO user (username, email, password, main_currency) VALUES (:username, :email, :password, :currency)";
    $insertStmt = $db->prepare($insertQuery);
    $insertStmt->bindParam(':username', $wallosUsername, SQLITE3_TEXT);
    $insertStmt->bindParam(':email', $wallosEmail, SQLITE3_TEXT);
    $insertStmt->bindParam(':password', $hashedPassword, SQLITE3_TEXT);
    $insertStmt->bindParam(':currency', $defaultCurrency, SQLITE3_INTEGER);
    
    if ($insertStmt->execute()) {
        $userId = $db->lastInsertRowID();
        
        // Create default categories
        $categories = [
            'Entertainment', 'Music', 'Video', 'Gaming', 
            'News', 'Health & Wellbeing', 'Productivity', 'Cloud Services'
        ];
        
        $catId = 1;
        foreach ($categories as $catName) {
            $catQuery = "INSERT INTO categories (id, name, user_id) VALUES (:id, :name, :userId)";
            $catStmt = $db->prepare($catQuery);
            $catStmt->bindParam(':id', $catId, SQLITE3_INTEGER);
            $catStmt->bindParam(':name', $catName, SQLITE3_TEXT);
            $catStmt->bindParam(':userId', $userId, SQLITE3_INTEGER);
            $catStmt->execute();
            $catId++;
        }
        
        // Log in the new user
        $_SESSION['loggedin'] = true;
        $_SESSION['userId'] = $userId;
        $_SESSION['username'] = $wallosUsername;
        return true;
    }
    
    return false;
}
?>
