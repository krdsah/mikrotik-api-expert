---
name: mikrotik-mvc-expert
description: Expert in applying MVC (Model-View-Controller) architectural standards to MikroTik API integrations in modern PHP and Laravel frameworks. Handles controllers, service layers, models, and background jobs for RouterOS operations.
---

# MikroTik MVC & Architecture Expert

## Purpose
This skill provides guidance on structuring MikroTik API integrations using MVC principles in modern PHP applications, specifically focusing on Laravel and custom PHP frameworks. It ensures scalable, secure, and maintainable interaction with RouterOS.

## When to Use
- Designing the architecture for MikroTik-related features.
- Creating or modifying controllers for network operations.
- Developing the service layer for complex RouterOS logic (billing, tunneling, provisioning).
- Implementing background workers or queue systems for MikroTik API commands.
- Structuring UI templates (Blade) that interact with RouterOS data.

## Key Information

### Service Layer (Crucial for MikroTik)
- **Decoupling**: Never put raw MikroTik API calls directly inside Controllers. Always abstract them into Services (e.g., `App\Services\MikrotikService`, `App\Services\HotspotService`).
- **Heavy Logic**: Move complex orchestration (e.g., creating a user, assigning a profile, and logging) to the Service layer.

### Background Jobs & Queues
- **Asynchronous Execution**: MikroTik API calls can timeout (RTO) or block. Always use queues (like Laravel's Queue system or custom background workers) for non-blocking operations.
- **Webhooks & Callbacks**: Webhooks (e.g., from payment gateways) should only insert a job into the database/queue. The actual RouterOS injection should be handled by a background worker.
- **Retry Logic**: Implement robust try-catch blocks and retry mechanisms in workers to handle network instability.

### Controllers
- **Thin Controllers**: Controllers should only handle HTTP requests, input validation, and returning views or JSON responses.
- **Dependency Injection**: Inject MikroTik services into the controller rather than instantiating them manually.
- **Redirection & Responses**: Return proper HTTP status codes for API responses, and use safe redirects for web interfaces.

### Models
- **Database Interaction**: Models should represent the local database state (e.g., `HotspotUser`, `RouterProfile`), not direct MikroTik API entities.
- **Synchronization**: Sync local data with RouterOS data via background jobs, not on every page load, to avoid performance bottlenecks.
- **Multi-Tenancy**: If managing multiple routers or users, always scope database queries appropriately (e.g., `where('router_id', ...)`) to prevent data leakage.

### Views & Frontend
- **Templating Engines**: Use modern templating like Laravel Blade or BladeOne.
- **No Inline Scripts/Styles**: Do not use injected raw PHP directives, inline CSS, or inline JS on templates to ensure CSP compliance.
- **Data Passing**: Pass backend variables to external scripts using `data-*` attributes on HTML elements or global configuration objects.

## Best Practices
- **Timeout Management**: Always configure reasonable timeouts for API connections to prevent application hangs when a router goes offline.
- **Security**: Never expose RouterOS credentials in the frontend. Keep them encrypted in the database or stored safely in `.env`.
- **Frontend & Assets**: Before applying specific frontend conventions (e.g., BEM, Tailwind, React, Vue), **always verify the user's existing tech stack**. Regardless of the stack, prefer modular, external assets and avoid inline scripts/styles to maintain security (CSP).
- **Error Handling**: Log all failed MikroTik API commands for auditing and debugging.
