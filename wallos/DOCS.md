# Wallos Home Assistant Add-on

Wallos is a powerful, open-source, self-hostable personal subscription tracker designed to help you manage recurring expenses and subscriptions.

## Features

- **Subscription Management** - Track recurring payments and due dates
- **Category Management** - Organize expenses into customizable categories
- **Multi-Currency Support** - Manage finances in multiple currencies
- **Statistics & Calendar Views** - Visualize spending patterns
- **Notifications** - Email, Discord, Pushover, Telegram, Gotify, and webhooks
- **Multi-Language Support**
- **OIDC/OAuth Authentication**
- **Mobile-friendly** with PWA support

## Installation

1. Add this repository to your Home Assistant Add-on Store
2. Install the "Wallos" add-on
3. Configure the add-on (see Configuration section)
4. Start the add-on
5. Access Wallos via the sidebar or at `http://[YOUR_HA_IP]:8282`

## Configuration

### Option: `timezone`

Set the timezone for Wallos. This affects date/time displays and scheduled tasks.

Default: `Europe/Berlin`

Example values: `America/New_York`, `Europe/London`, `Asia/Tokyo`

## Accessing Wallos

### Via Ingress

Wallos supports Home Assistant Ingress, which means you can access it directly from the Home Assistant sidebar without exposing additional ports.

### Via Direct Access

You can also access Wallos directly at:

- `http://[YOUR_HA_IP]:8282`

## Data Storage

All Wallos data is stored persistently in the Home Assistant add-on data directory:

- Database: `/data/wallos/db/wallos.db`
- Uploaded logos: `/data/wallos/logos/`
- Temporary files: `/data/wallos/tmp/`

This data is automatically included in Home Assistant backups.

## First-Time Setup

1. After starting the add-on, access Wallos via the sidebar or direct URL
2. Create your admin account on first login
3. Configure your preferred currency and notification settings
4. Start adding your subscriptions!

## Support

For issues and feature requests, please visit the [GitHub repository](https://github.com/Riza-Aslan/Wallos-HA).

For general Wallos support, visit the [official Wallos repository](https://github.com/ellite/Wallos).
