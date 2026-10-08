# MikroTik RouterOS v6 API Commands (Legacy)

## Table of Contents
- [Connection & Syntax](#connection--syntax)
- [System Management](#system-management)
- [Interfaces](#interfaces)
- [IP Settings](#ip-settings)
- [Hotspot Management](#hotspot-management)
- [PPP / PPPoE](#ppp--pppoe)
- [Queues & Bandwidth Management](#queues--bandwidth-management)
- [Routing](#routing)
- [Tools & Logging](#tools--logging)

---

## Connection & Syntax
- **Default ports:** 8728 (API), 8729 (API-SSL).
- **Command Syntax:** Maps directly to the RouterOS CLI. E.g., `ip address print` becomes `/ip/address/print`.
- **Properties:** Prefixed with `=`, e.g., `=name=john`.
- **Filters:** Prefixed with `?`, e.g., `?disabled=false`.
- **Return Attributes:** Prefixed with `.`, e.g., `.proplist=.id,name`.

## System Management
Commands to manage the router's core system functions.

### Resource & Identity
- `/system/resource/print` : Get CPU, RAM, disk usage, and uptime.
- `/system/identity/print` : Get router identity.
- `/system/identity/set` : Set router identity (Params: `name`).

### Users & Permissions
- `/user/print` : List system users.
- `/user/add` : Add a new user (Params: `name`, `password`, `group`).
- `/user/active/print` : List currently connected users.

### Maintenance
- `/system/reboot` : Reboot the router.
- `/system/shutdown` : Shutdown the router.
- `/system/package/update/check-for-updates` : Check for RouterOS updates.
- `/system/backup/save` : Create a system backup (Params: `name`).

## Interfaces
Manage physical and virtual interfaces.

### General Interfaces
- `/interface/print` : List all interfaces.
- `/interface/set` : Edit an interface (Params: `.id`, `disabled`, `comment`).
- `/interface/monitor-traffic` : Monitor live traffic (Params: `interface`, `once`).

### Specific Interface Types
- `/interface/wireless/print` : List wireless interfaces.
- `/interface/bridge/print` : List bridges.
- `/interface/bridge/port/print` : List bridge ports.
- `/interface/vlan/print` : List VLANs.

## IP Settings
Manage IPv4 networking features.

### Addressing & Routing
- `/ip/address/print` : List IP addresses.
- `/ip/address/add` : Add an IP address (Params: `address`, `interface`).
- `/ip/route/print` : List routing table entries.
- `/ip/route/add` : Add a static route (Params: `dst-address`, `gateway`).

### DHCP
- `/ip/dhcp-client/print` : List DHCP clients.
- `/ip/dhcp-server/print` : List DHCP servers.
- `/ip/dhcp-server/lease/print` : List active DHCP leases.
- `/ip/dhcp-server/lease/remove` : Remove a lease (Params: `.id`).

### DNS & Services
- `/ip/dns/print` : View DNS settings.
- `/ip/dns/set` : Set DNS servers (Params: `servers`).
- `/ip/service/print` : List router services (API, SSH, Winbox, etc.).

### Firewall & NAT
- `/ip/firewall/filter/print` : List firewall filter rules.
- `/ip/firewall/nat/print` : List NAT rules.
- `/ip/firewall/mangle/print` : List mangle rules.
- `/ip/firewall/connection/print` : View active tracking connections.

## Hotspot Management
Manage the captive portal/hotspot feature.

### Users & Profiles
- `/ip/hotspot/user/print` : List hotspot users.
- `/ip/hotspot/user/add` : Add a user (Params: `name`, `password`, `profile`, `limit-uptime`, `comment`).
- `/ip/hotspot/user/remove` : Remove a user (Params: `.id`).
- `/ip/hotspot/user/profile/print` : List user profiles (rate limits, shared users).
- `/ip/hotspot/user/profile/add` : Create a profile (Params: `name`, `rate-limit`).

### Active Sessions
- `/ip/hotspot/active/print` : List logged-in hotspot users.
- `/ip/hotspot/active/remove` : Kick a user (Params: `.id`).

## PPP / PPPoE
Manage VPN and Point-to-Point connections.

- `/ppp/secret/print` : List PPP secrets (users).
- `/ppp/secret/add` : Add a PPP user (Params: `name`, `password`, `service`, `profile`).
- `/ppp/profile/print` : List PPP profiles.
- `/ppp/active/print` : List active PPP connections.

## Queues & Bandwidth Management
Manage traffic shaping.

- `/queue/simple/print` : List simple queues.
- `/queue/simple/add` : Add a queue (Params: `name`, `target`, `max-limit`).
- `/queue/tree/print` : List queue trees.
- `/queue/type/print` : List queue types (PCQ, RED, etc.).

## Routing
Manage dynamic routing protocols (BGP, OSPF).

- `/routing/ospf/neighbor/print` : List OSPF neighbors.
- `/routing/bgp/peer/print` : List BGP peers.
- `/routing/filter/print` : List routing filters.

## Tools & Logging
Diagnostic utilities.

- `/ping` : Ping an IP (Params: `address`, `count`).
- `/tool/mac-ping` : Ping a MAC address.
- `/tool/torch` : Real-time traffic monitoring.
- `/log/print` : View router system logs.
