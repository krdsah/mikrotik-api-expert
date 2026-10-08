---
name: mikrotik-nodejs-api-expert
description: Expert in MikroTik RouterOS API (v6 and v7) integration with Node.js. Handles connection, async/await operations, streams, and REST API integration in modern Node.js and TypeScript applications.
---

# MikroTik Node.js API Expert

## Purpose
This skill provides guidance and best practices for interacting with MikroTik RouterOS via API within Node.js applications (including Express, NestJS, and background workers). It covers both the legacy RouterOS API (ROS v6) and the REST API (ROS v7).

## When to Use
- Implementing new MikroTik API commands in a Node.js or TypeScript project.
- Creating or modifying MikroTik services, wrappers, or API clients using Node.js.
- Troubleshooting asynchronous RouterOS connections or promise rejections.
- Handling version-specific differences between ROS v6 and v7 in a JavaScript environment.

## Key Information

### Command References
For detailed command lists and parameters, see:
- [v6_COMMANDS.md](v6_COMMANDS.md) (Legacy API)
- [v7_COMMANDS.md](v7_COMMANDS.md) (REST API)

### Common Node.js Approaches
Node.js projects typically interact with RouterOS using one of two methods depending on the ROS version:

1.  **ROS v6 (Legacy API - Port 8728/8729):**
    -   Uses NPM packages like `node-routeros` or `routeros-client`.
    -   Leverages Node's event-driven architecture to handle streams and sentences coming from the router.
    -   Best wrapped in `async/await` for modern usage.

2.  **ROS v7 (REST API - Port 80/443):**
    -   Uses native `fetch` (Node 18+) or HTTP clients like `axios`.
    -   Communicates using standard JSON over HTTP(S).

### Usage Pattern Examples

**1. Axios / Native Fetch (ROS v7 REST API):**
```javascript
import axios from 'axios';
import https from 'https';

// Setup agent to ignore self-signed certs (if applicable)
const httpsAgent = new https.Agent({ rejectUnauthorized: false });

async function getHotspotUsers() {
    try {
        const response = await axios.get('https://192.168.88.1/rest/ip/hotspot/user', {
            auth: { username: 'admin', password: 'password' },
            httpsAgent
        });
        return response.data;
    } catch (error) {
        console.error('MikroTik API Error:', error.message);
    }
}
```

**2. Node-RouterOS Package (ROS v6 Legacy API):**
```javascript
import { RouterOSClient } from 'routeros-client';

async function getHotspotUsersV6() {
    const api = new RouterOSClient({
        host: '192.168.88.1',
        user: 'admin',
        password: 'password'
    });

    try {
        const client = await api.connect();
        const users = await client.menu('/ip/hotspot/user').get();
        client.close();
        return users;
    } catch (error) {
        console.error('Connection failed:', error);
    }
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
- **Async/Await:** Always use `async/await` and `try/catch` blocks to handle API calls to prevent unhandled promise rejections.
- **Connection Pooling:** For high-traffic applications using v6, consider keeping connections alive or using connection pooling, as establishing TCP connections repeatedly is slow.
- **REST Preferred:** ROS v7 REST API is strongly preferred for modern Node.js applications. It's stateless, fast, and works seamlessly with JSON and Axios/Fetch.
- **TLS/SSL Security:** Use HTTPS (port 443) for the REST API. You may need to bypass certificate validation (`rejectUnauthorized: false`) in local development if using self-signed MikroTik certificates, but enforce valid certificates in production.
- **Event Listeners:** If using legacy v6 packages, ensure event listeners are cleaned up to prevent memory leaks in long-running Node processes.
