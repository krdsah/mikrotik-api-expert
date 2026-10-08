# Contributing to MikroTik API Expert Skills

Thanks for your interest in contributing! To ensure your PR is approved quickly, please follow these guidelines:

## 1. File Structure & Documentation Rules
- **SKILL.md**: Each folder contains a `SKILL.md` detailing basic concepts, best practices, and framework-specific patterns (PHP, Laravel, Node.js).
- **v6_COMMANDS.md**: Dedicated to Socket API commands (Port 8728/8729) using CLI/API Word format.
- **v7_COMMANDS.md**: Dedicated to REST API commands (Port 80/443) using HTTP methods (`GET`, `PUT`, `PATCH`, `DELETE`, `POST`) and JSON payload format.

## 2. Accepted Pull Request Criteria
1. **RouterOS v7 REST Writing Rules:**
- Use the appropriate HTTP method (`GET` = print, `PUT` = add, `PATCH` = set, `DELETE` = remove). 
- Ensure internal ID variables use the `*1` or `{id}` format.
2. **Feature Compatibility:**
- v7-specific features (such as WireGuard or BGP Sessions) **must only** be included in `v7_COMMANDS.md`.
3. **Markdown Format:**
- Use a consistent Markdown scheme that aligns with the existing table structure.

## 3. PR Submission Workflow
1. Fork this repository.
2. Create a new branch for the feature/fix (`git checkout -b fix/v7-wireguard-endpoint`).
3. Commit your changes with a clear commit message (`feat: add wireguard REST endpoints`).
4. Push to your branch and create a Pull Request targeting the `main` branch.