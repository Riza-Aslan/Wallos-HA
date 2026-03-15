<?php
/**
 * SSO Patch for Wallos index.php
 * 
 * This script patches the Wallos index.php to include SSO auto-login.
 * Run this after each Wallos update.
 */

$indexFile = '/var/www/html/index.php';
$ssoInclude = '
// Home Assistant SSO Auto-Login
if (file_exists(__DIR__ . \'/sso_auth.php\')) {
    require_once __DIR__ . \'/sso_auth.php\';
    handleHASSO($db);
}
';

if (!file_exists($indexFile)) {
    echo "index.php not found!\n";
    exit(1);
}

$content = file_get_contents($indexFile);

// Check if SSO is already patched
if (strpos($content, 'sso_auth.php') !== false) {
    echo "SSO already patched.\n";
    exit(0);
}

// Find the session_start() line and add SSO after it
$pattern = '/(session_start\(\);)/';
$replacement = '$1' . "\n" . $ssoInclude;

$newContent = preg_replace($pattern, $replacement, $content, 1);

if ($newContent === $content) {
    // Pattern not found, try alternative
    // Look for the first require/include after session_start
    $pattern = '/(session_start\(\);[\s\S]*?)(require_once|include)/';
    $replacement = '$1' . $ssoInclude . '$2';
    $newContent = preg_replace($pattern, $replacement, $content, 1);
}

if ($newContent !== $content) {
    file_put_contents($indexFile, $newContent);
    echo "SSO patched successfully.\n";
} else {
    echo "Could not find insertion point. Manual patching required.\n";
    echo "Add the following after session_start():\n";
    echo $ssoInclude;
}
?>
