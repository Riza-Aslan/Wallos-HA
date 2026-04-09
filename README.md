# Wallos Home Assistant Add-on

[![GitHub Release](https://img.shields.io/github/v/release/Riza-Aslan/Wallos-HA)](https://github.com/Riza-Aslan/Wallos-HA/releases)
[![License](https://img.shields.io/github/license/Riza-Aslan/Wallos-HA)](https://github.com/Riza-Aslan/Wallos-HA/blob/main/LICENSE)
[![GitHub Sponsors](https://img.shields.io/github/sponsors/Riza-Aslan)](https://github.com/sponsors/Riza-Aslan)

## ❤️ Support

If you find this add-on useful, please consider supporting its development:

[![GitHub Sponsors](https://img.shields.io/badge/Sponsor-Riza--Aslan-ea4aaa?logo=github-sponsors&logoColor=white)](https://github.com/sponsors/Riza-Aslan)
[![PayPal](https://img.shields.io/badge/PayPal-Donate-00457C?logo=paypal&logoColor=white)](https://www.paypal.com/paypalme/rizaaslan)

Home Assistant Add-on for [Wallos](https://github.com/ellite/Wallos) - a powerful, open-source, self-hostable personal subscription tracker.

**Current Version:** 4.8.0

## About

This add-on packages [Wallos](https://github.com/ellite/Wallos) for easy installation in Home Assistant. Wallos is developed by [Miguel Ribeiro (ellite)](https://github.com/ellite) and helps you manage recurring expenses and subscriptions with features like:

- **Subscription Management** - Track recurring payments and due dates
- **Category Management** - Organize expenses into customizable categories
- **Multi-Currency Support** - Manage finances in multiple currencies
- **Statistics & Calendar Views** - Visualize spending patterns
- **Notifications** - Email, Discord, Pushover, Telegram, Gotify, and webhooks
- **Multi-Language Support**
- **OIDC/OAuth Authentication**
- **Mobile-friendly** with PWA support

## Installation

1. Add this repository to your Home Assistant Add-on Store as a Custom Repository:
   ```
   https://github.com/Riza-Aslan/Wallos-HA
   ```
2. Install the "Wallos" add-on
3. Configure the add-on (see Configuration section)
4. Start the add-on
5. Access Wallos via the sidebar or directly at `http://[YOUR_HA_IP]:8282`

> **Note on Ingress:** Ingress is fully supported! You can add Wallos to your sidebar and access it remotely, provided your Home Assistant is configured for remote access.

---

## 🛠️ Setup & Optimizations

### Migrating Existing Data
If you have used Wallos already, you can easily migrate your data:
1. Go to **Admin** -> **Backup and Recovery** in your old instance.
2. Create a backup and download it.
3. Restore it inside the new Wallos-HA instance.

### Server URL Configuration
To ensure proper routing, copy the Wallos URL from the Home Assistant sidebar and paste it as the **Server-URL** in the Wallos admin settings:

### Seamless Login
Since you are already logged into Home Assistant, you don't need double authentication. You can turn off the login screen in the Wallos settings for a smoother, seamless experience.

### Visual Integration (HA Theme)
I've changed the background color of Wallos to match the Home Assistant sidebar color. If you want to customize it further or ensure it matches perfectly, you can add this in the Wallos settings under **Custom CSS**:

```css
body {
 background-color: #101215;
}
```

## Configuration

| Option | Description | Default |
|--------|-------------|---------|
| `timezone` | Timezone for Wallos | `Europe/Berlin` |

## Supported Architectures

- armhf
- armv7
- aarch64
- amd64
- i386

## Data Storage

All Wallos data is stored persistently in the Home Assistant add-on data directory (`/data/`) and is automatically included in Home Assistant backups.

### Storage Structure

| Path | Content | Persistent |
|------|---------|------------|
| `/data/db/` | SQLite database and WAL files | ✅ Yes |
| `/data/wallos/logos/` | Uploaded subscription logos | ✅ Yes |
| `/data/wallos/tmp/` | Temporary files | ✅ Yes |

### Backup & Restore

To backup your data, copy the entire `/data/db/` directory to a safe location. To restore, place the backup files in `/data/db/` and restart the add-on.

### Database Import

You can import databases directly through the Wallos web interface. The add-on will automatically handle the persistence without any manual intervention required.

## 📊 Home Assistant Integration (REST API)

You can integrate your Wallos subscriptions directly as sensors in your Home Assistant dashboard using the official Wallos API. Full API documentation is available at [api.wallosapp.com](https://api.wallosapp.com/).

### Prerequisites

1. Open Wallos via the Home Assistant sidebar (Ingress) or directly at `(http://[YOUR_HA_IP]:8282)`
2. Go to **Settings** → **API**
3. Generate an API key
4. Add the API key to your `secrets.yaml` (located in `/config/secrets.yaml`):
   ```yaml
   wallos_api_key: "your_api_key_here"
   ```

### Available API Endpoints

| Endpoint | Description | Parameters |
|----------|-------------|------------|
| `/api/subscriptions/get_monthly_cost.php` | Monthly subscription costs | `month`, `year` |
| `/api/subscriptions/get_subscriptions.php` | List all subscriptions | `member`, `category`, `payment_method`, `state`, `sort`, `convert_currency` |
| `/api/categories/get_categories.php` | List all categories | - |
| `/api/currencies/get_currencies.php` | List currencies & main currency | - |
| `/api/payment_methods/get_payment_methods.php` | List payment methods | - |
| `/api/household/get_household.php` | List household members | - |
| `/api/settings/get_settings.php` | Get user settings | - |
| `/api/admin/get_admin_settings.php` | Get admin settings | - |
| `/api/notifications/get_notification_settings.php` | Get notification settings | - |
| `/api/fixer/get_fixer.php` | Get Fixer API settings | - |

### REST Sensors Configuration

Add the following to your `configuration.yaml`. Replace `http://localhost:8282` with your actual Home Assistant IP address if needed:

```yaml
rest:
  # Sensor 1: Monthly Costs
  - resource: "http://localhost:8282/api/subscriptions/get_monthly_cost.php"
    verify_ssl: false
    scan_interval: 3600
    params:
      month: "{{ now().month }}"
      year: "{{ now().year }}"
      api_key: !secret wallos_api_key
    sensor:
      - name: "Wallos Monthly Cost"
        value_template: "{{ value_json.monthly_cost | replace(',', '') }}"
        unit_of_measurement: "€"
        device_class: monetary
        state_class: measurement

  # Sensor 2: Active Subscriptions Count
  - resource: "http://localhost:8282/api/subscriptions/get_subscriptions.php"
    verify_ssl: false
    scan_interval: 3600
    params:
      api_key: !secret wallos_api_key
      state: "0"
    sensor:
      - name: "Wallos Active Subscriptions"
        value_template: "{{ value_json.subscriptions | length }}"
        unit_of_measurement: "subscriptions"
        icon: mdi:wallet-membership
        state_class: measurement

  # Sensor 3: Categories Count
  - resource: "http://localhost:8282/api/categories/get_categories.php"
    verify_ssl: false
    scan_interval: 3600
    params:
      api_key: !secret wallos_api_key
    sensor:
      - name: "Wallos Categories"
        value_template: "{{ value_json.categories | length }}"
        unit_of_measurement: "categories"
        icon: mdi:tag-multiple
        state_class: measurement

  # Sensor 4: Payment Methods Count
  - resource: "http://localhost:8282/api/payment_methods/get_payment_methods.php"
    verify_ssl: false
    scan_interval: 3600
    params:
      api_key: !secret wallos_api_key
    sensor:
      - name: "Wallos Payment Methods"
        value_template: "{{ value_json.payment_methods | length }}"
        unit_of_measurement: "methods"
        icon: mdi:credit-card-multiple
        state_class: measurement

  # Sensor 5: Household Members Count
  - resource: "http://localhost:8282/api/household/get_household.php"
    verify_ssl: false
    scan_interval: 3600
    params:
      api_key: !secret wallos_api_key
    sensor:
      - name: "Wallos Household Members"
        value_template: "{{ value_json.household | length }}"
        unit_of_measurement: "members"
        icon: mdi:account-group
        state_class: measurement
```

### 🎨 Dashboard Card Examples (Lovelace)

After restarting Home Assistant, you can add these cards to your dashboard:

#### 1. Compact Overview (Entities Card)

```yaml
type: entities
title: 💸 My Subscriptions
entities:
  - entity: sensor.wallos_monthly_cost
    name: This Month
    icon: mdi:calendar-month
  - entity: sensor.wallos_active_subscriptions
    name: Active
    icon: mdi:wallet-membership
```

#### 2. Statistics Grid (Grid Card)

```yaml
type: grid
columns: 2
cards:
  - type: gauge
    entity: sensor.wallos_monthly_cost
    name: Monthly
    min: 0
    max: 500
    severity:
      green: 0
      yellow: 200
      red: 400
  - type: statistic
    entity: sensor.wallos_active_subscriptions
    name: Subscriptions
    stat: value
  - type: statistic
    entity: sensor.wallos_categories
    name: Categories
    stat: value
```

#### 3. Markdown Summary

```yaml
type: markdown
content: >
  ## 📊 Subscription Overview

  | Metric | Value |
  |--------|-------|
  | Monthly Cost | {{ states('sensor.wallos_monthly_cost') }}€ |
  | Active Subscriptions | {{ states('sensor.wallos_active_subscriptions') }} |
  | Categories | {{ states('sensor.wallos_categories') }} |
  | Payment Methods | {{ states('sensor.wallos_payment_methods') }} |
  | Household Members | {{ states('sensor.wallos_household_members') }} |
```

## License

This add-on is licensed under the [MIT License](LICENSE). The underlying [Wallos application](https://github.com/ellite/Wallos) is licensed under [GPL-3.0](https://github.com/ellite/Wallos/blob/main/LICENSE.md).
