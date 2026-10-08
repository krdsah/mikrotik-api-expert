# MikroTik RouterOS v7 REST API Commands

## Table of Contents
- [Connection & REST Mapping](#connection--rest-mapping)
- [System Management](#system-management)
- [Interfaces](#interfaces)
- [IP Settings](#ip-settings)
- [Hotspot Management](#hotspot-management)
- [PPP / PPPoE](#ppp--pppoe)
- [Queues & Bandwidth Management](#queues--bandwidth-management)
- [Routing](#routing)
- [Tools & Logging](#tools--logging)

---

## Connection & REST Mapping
- **Default ports:** 80 (HTTP), 443 (HTTPS).
- **Endpoint Prefix:** `/rest/` (e.g., `https://router-ip/rest/ip/address`).
- **Standard REST mappings for MikroTik API commands:**
  - `GET`: Retrieve data (equivalent to `/print`).
  - `PUT`: Create new entries (equivalent to `/add`). Send JSON body.
  - `PATCH`: Update existing entries (equivalent to `/set`). Send JSON body.
  - `DELETE`: Remove entries (equivalent to `/remove`). E.g., `DELETE /rest/ip/address/*1`.
  - `POST`: Execute actions (equivalent to commands without print/add/set/remove). E.g., `POST /rest/ping`. Send JSON body for arguments.
- **IDs**: When updating or deleting, use the specific RouterOS internal ID prefixed with `*`, e.g., `/rest/ip/address/*1`.

## System Management

### Resource & Identity
- `GET /rest/system/resource` : Get CPU, RAM, disk usage, and uptime.
- `GET /rest/system/identity` : Get router identity.
- `PATCH /rest/system/identity` : Set router identity (Body: `{"name": "new-name"}`).

### Users & Permissions
- `GET /rest/user` : List system users.
- `PUT /rest/user` : Add a new user (Body: `{"name": "admin2", "password": "pass", "group": "full"}`).
- `GET /rest/user/active` : List currently connected users.

### Maintenance
- `POST /rest/system/reboot` : Reboot the router.
- `POST /rest/system/shutdown` : Shutdown the router.
- `POST /rest/system/package/update/check-for-updates` : Check for RouterOS updates.

## Interfaces

### General Interfaces
- `GET /rest/interface` : List all interfaces.
- `PATCH /rest/interface/{id}` : Edit an interface (Body: `{"disabled": "true", "comment": "disabled-via-api"}`).
- `POST /rest/interface/monitor-traffic` : Monitor live traffic (Body: `{"interface": "ether1", "once": ""}`).

### Specific Interface Types
- `GET /rest/interface/wireless` : List wireless interfaces.
- `GET /rest/interface/bridge` : List bridges.
- `GET /rest/interface/bridge/port` : List bridge ports.
- `GET /rest/interface/vlan` : List VLANs.

## IP Settings

### Addressing & Routing
- `GET /rest/ip/address` : List IP addresses.
- `PUT /rest/ip/address` : Add an IP address (Body: `{"address": "192.168.1.1/24", "interface": "ether1"}`).
- `GET /rest/ip/route` : List routing table entries.
- `PUT /rest/ip/route` : Add a static route (Body: `{"dst-address": "0.0.0.0/0", "gateway": "192.168.1.254"}`).

### DHCP
- `GET /rest/ip/dhcp-client` : List DHCP clients.
- `GET /rest/ip/dhcp-server` : List DHCP servers.
- `GET /rest/ip/dhcp-server/lease` : List active DHCP leases.
- `DELETE /rest/ip/dhcp-server/lease/{id}` : Remove a DHCP lease.

### DNS & Services
- `GET /rest/ip/dns` : View DNS settings.
- `PATCH /rest/ip/dns` : Set DNS servers (Body: `{"servers": "8.8.8.8,1.1.1.1"}`).
- `GET /rest/ip/service` : List router services (API, SSH, HTTP, etc.).

### Firewall & NAT
- `GET /rest/ip/firewall/filter` : List firewall filter rules.
- `GET /rest/ip/firewall/nat` : List NAT rules.
- `GET /rest/ip/firewall/mangle` : List mangle rules.
- `GET /rest/ip/firewall/connection` : View active tracking connections.

## Hotspot Management

### Users & Profiles
- `GET /rest/ip/hotspot/user` : List hotspot users.
- `PUT /rest/ip/hotspot/user` : Add a user (Body: `{"name": "john", "password": "123", "profile": "default"}`).
- `DELETE /rest/ip/hotspot/user/{id}` : Remove a user.
- `GET /rest/ip/hotspot/user/profile` : List user profiles.
- `PUT /rest/ip/hotspot/user/profile` : Create a profile (Body: `{"name": "vip", "rate-limit": "10M/10M"}`).

### Active Sessions
- `GET /rest/ip/hotspot/active` : List logged-in hotspot users.
- `DELETE /rest/ip/hotspot/active/{id}` : Kick an active user session.

## PPP / PPPoE

- `GET /rest/ppp/secret` : List PPP secrets (users).
- `PUT /rest/ppp/secret` : Add a PPP user (Body: `{"name": "vpn-user", "password": "pass", "service": "pppoe"}`).
- `GET /rest/ppp/profile` : List PPP profiles.
- `GET /rest/ppp/active` : List active PPP connections.

## Queues & Bandwidth Management

- `GET /rest/queue/simple` : List simple queues.
- `PUT /rest/queue/simple` : Add a simple queue (Body: `{"name": "client-1", "target": "192.168.1.10", "max-limit": "5M/5M"}`).
- `GET /rest/queue/tree` : List queue trees.
- `GET /rest/queue/type` : List queue types.

## Routing
*Note: v7 overhauled routing significantly compared to v6.*
- `GET /rest/routing/ospf/neighbor` : List OSPF neighbors.
- `GET /rest/routing/bgp/session` : List BGP sessions (Note: `peer` in v6 changed to `connection` and `session` in v7).
- `GET /rest/routing/filter/rule` : List routing filter rules.

## Tools & Logging

- `POST /rest/ping` : Ping an IP (Body: `{"address": "8.8.8.8", "count": "3"}`).
- `POST /rest/tool/mac-ping` : Ping a MAC address (Body: `{"mac-address": "AA:BB:CC:DD:EE:FF"}`).
- `GET /rest/log` : View router system logs.
