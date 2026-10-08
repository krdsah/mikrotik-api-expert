---
name: mikrotik-laravel-expert
description: Expert in integrating MikroTik RouterOS API specifically within the Laravel ecosystem. Handles Eloquent models, Laravel Jobs/Queues, Service Providers, and HTTP client integration for RouterOS v7.
---

# MikroTik Laravel Architecture Expert

## Purpose
This skill provides specific guidance on integrating MikroTik RouterOS via API natively within the Laravel framework. It ensures you are leveraging Laravel's powerful built-in features (Eloquent, Queues, Service Providers, HTTP Client) to build scalable and robust network management applications.

## When to Use
- Building MikroTik features exclusively inside a Laravel application.
- Setting up Laravel Queues (or Horizon) for RouterOS operations.
- Writing Laravel Service Providers to bind MikroTik API clients.
- Using Eloquent Models to represent RouterOS entities in a local database.
- Consuming the MikroTik v7 REST API using Laravel's `Http` facade.

## Key Information

### Service Providers & Binding
- **Configuration**: Store router credentials in `config/mikrotik.php` (loaded from `.env`).
- **Service Container**: Create a `MikrotikServiceProvider` to bind your MikroTik API client as a singleton in the Laravel service container.
- **Facades**: (Optional) Create a Facade (e.g., `Mikrotik::`) to easily call API methods globally.

### Service Layer
- **Abstraction**: Never inject the API client directly into Controllers. Create Service classes (e.g., `app/Services/RouterOSService.php`) that the controller resolves via Dependency Injection.
- **Form Requests**: Use Laravel's Form Requests (`php artisan make:request`) to validate data before passing it to the Service layer.

### Background Jobs & Queues (Laravel Specifics)
- **Queued Jobs**: Use `php artisan make:job ProcessMikrotikCommand`. All MikroTik API interactions that don't require an instant UI response should be dispatched to a queue.
- **Timeouts & Retries**: Configure `$tries` and `$backoff` in your Job classes to handle RouterOS Request Timeouts (RTO) or temporary unreachability gracefully.
- **Events/Listeners**: Fire Laravel Events (e.g., `UserConnectedToHotspot`) and handle API synchronization inside queued Listeners.

### Eloquent Models & Syncing
- **Database Representation**: Use Eloquent models to cache MikroTik data (e.g., `App\Models\HotspotUser`). This prevents querying the router on every page load.
- **Synchronization**: Use Laravel Task Scheduling (`app/Console/Kernel.php` or `routes/console.php` in Laravel 11+) to periodically dispatch Jobs that sync local database state with the actual RouterOS state.
- **Mass Assignment**: Protect your Eloquent models using `$fillable` or `$guarded`.

### v7 REST API with Laravel HTTP Client
- **Http Facade**: For RouterOS v7, strongly prefer using Laravel's built-in HTTP client over custom cURL wrappers.
  ```php
  use Illuminate\Support\Facades\Http;
  
  $response = Http::withBasicAuth(config('mikrotik.user'), config('mikrotik.pass'))
                  ->withOptions(['verify' => false]) // If self-signed
                  ->get('https://' . config('mikrotik.host') . '/rest/ip/hotspot/user');
  ```

### Views & Frontend
- **Blade Components**: Use Laravel Blade components (`<x-mikrotik-status />`) to encapsulate UI elements related to RouterOS.
- **Inertia.js / Livewire**: When using modern Laravel frontends, ensure all MikroTik data is processed by the backend and passed down as clean JSON or state, never making direct API calls from the frontend.

## Best Practices
- **Never Block the Request**: API calls can be slow. Use queues.
- **Environment Variables**: Always use `.env` for IP, Username, and Password. Never hardcode them.
- **Robust Error Logging**: Use Laravel's `Log` facade (`Log::error(...)`) to capture any API connection failures or exceptions.
