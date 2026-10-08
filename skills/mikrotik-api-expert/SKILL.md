---
name: mikrotik-api-expert
description: Expert in MikroTik RouterOS API (v6 and v7). Handles connection, command execution, and integration with common PHP applications and the Laravel framework. Use when modifying MikroTik API interactions, drivers, or services that communicate with RouterOS.
---

# MikroTik API Expert

## Purpose
This skill provides guidance and best practices for interacting with MikroTik RouterOS via API within common PHP applications and the Laravel framework. It covers both the legacy RouterOS API (ROS v6) and the REST API (ROS v7).

## When to Use
- Implementing new MikroTik API commands in PHP or Laravel.
- Creating or modifying MikroTik services, wrappers, or API clients.
- Troubleshooting RouterOS connection or command execution issues.
- Handling version-specific differences between ROS v6 and v7.

## Key Information

### Command References
For detailed command lists and parameters, see:
- [v6_COMMANDS.md](v6_COMMANDS.md) (Legacy API)
- [v7_COMMANDS.md](v7_COMMANDS.md) (REST API)

### Common PHP/Laravel Approaches
PHP and Laravel projects typically interact with RouterOS using one of two methods depending on the ROS version:

1.  **ROS v6 (Legacy API - Port 8728/8729):**
    -   Uses traditional API clients like `routeros_api.class.php` (by Denis Basta/Ben Menking) or packages like `evilbox/mikrotik-routeros-api-php`.
    -   Communicates using the custom MikroTik API protocol with sentences and words.

2.  **ROS v7 (REST API - Port 80/443):**
    -   Uses standard HTTP clients like Guzzle (`GuzzleHttp\Client`) or Laravel's HTTP Facade (`Illuminate\Support\Facades\Http`).
    -   Communicates using standard JSON over HTTP(S).

### Usage Pattern Examples

**1. Laravel HTTP Client (ROS v7 REST API):**
```php
use Illuminate\Support\Facades\Http;

$response = Http::withBasicAuth('admin', 'password')
    ->withOptions(['verify' => false]) // Often needed for self-signed certs
    ->get('https://192.168.88.1/rest/ip/hotspot/user');

if ($response->successful()) {
    $users = $response->json();
}
```

**2. Traditional PHP Client (ROS v6 Legacy API using `routeros_api.class.php`):**
```php
require('routeros_api.class.php');
$api = new RouterosAPI();

if ($api->connect('192.168.88.1', 'admin', 'password')) {
    $api->write('/ip/hotspot/user/print');
    $users = $api->read();
    $api->disconnect();
}
```

### Command Formatting
When designing services to support both versions, consider the mapping differences:
- **v6 (API):** Uses standard API command strings (e.g., `/ip/hotspot/user/print`, `/ip/hotspot/user/add`).
- **v7 (REST):** Maps commands to REST endpoints and HTTP methods.
  - `add` -> `PUT`
  - `set` -> `PATCH`
  - `remove` -> `DELETE`
  - `print` (or no suffix) -> `GET`

### Common Commands
- `/ip/hotspot/user/print` (or `GET /rest/ip/hotspot/user`): List hotspot users.
- `/ip/hotspot/user/add` (or `PUT /rest/ip/hotspot/user`): Add a new hotspot user.
- `/system/resource/print` (or `GET /rest/system/resource`): Get system information.
- `/interface/print` (or `GET /rest/interface`): List network interfaces.

## Best Practices
- **Connection Checks:** Always verify the connection status (or HTTP status code) before processing data.
- **Error Handling:** Implement robust `try-catch` blocks for network errors and log API failures.
- **REST Preferred:** ROS v7 REST API is preferred for newer devices due to its JSON native support, better performance, and ease of use with standard HTTP libraries.
- **Security:** Use HTTPS (port 443) for the REST API and secure API (port 8729) for the legacy API whenever possible to encrypt credentials. Handle SSL certificate verification properly in production environments.
