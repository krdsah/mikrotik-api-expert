# MikroTik API Expert Skills & Tools for AI Assistants

This repository contains a collection of AI coding assistant skills and tools designed specifically for developing against the MikroTik RouterOS API using various modern frameworks and languages.

These skills are optimized for **Antigravity**, **Claude Code**, **OpenCode**, **Command Code**, **Codex**, and other modern AI assistants, helping them understand MikroTik-specific architecture, routing, API commands, and best practices.

## Included Skills

- **`mikrotik-api-expert`**: General guidance for legacy (v6) and REST (v7) RouterOS API usage in raw PHP.
- **`mikrotik-mvc-expert`**: Architectural standards for integrating MikroTik API calls using MVC patterns (Services, Background Jobs).
- **`mikrotik-laravel-expert`**: Laravel-specific implementation guidelines, including Eloquent, Horizon/Queues, Service Providers, and the HTTP facade.
- **`mikrotik-nodejs-api-expert`**: Node.js and TypeScript specific guidelines, focusing on asynchronous patterns, Promises, and modern HTTP clients (`axios`/`fetch`).
- **`skill-rules.json`**: Automated trigger mapping that tells the AI exactly when to activate each skill based on file paths and keywords.

## Included Tools (MCP Server)

This repository includes a native **Model Context Protocol (MCP)** server that gives the AI the ability to run advanced network diagnostics directly from the chat interface.

- **`tools/mcp_mikrotik.py`**: A Python-based FastMCP server that performs ICMP ping tests and port scans on standard RouterOS ports (80, 443, 8728, 8729, 8291, 22).
- **`mcp_config.json`**: Configuration file that mounts the tool into compatible AI agents.

### Installing the Tool
To allow your AI to use the diagnostic tool, you must install the Python MCP SDK:
```bash
pip install mcp
```
Once installed, place `mcp_config.json` in your project root or your AI's global MCP config directory. You can then ask your AI: *"Check if the MikroTik router at 192.168.88.1 is online."*

## Installation

### The Omni-Installer (Recommended)
The easiest way to install this plugin (which includes all skills and tools) globally across all your AI assistants is to run our omni-installer in your terminal:

```bash
curl -fsSL https://raw.githubusercontent.com/username/mikrotik-api-expert/main/install.sh | bash
```

**What the installer does:**
1. Clones the repository to a central `~/.mikrotik-ai-expert` directory.
2. Detects which AI assistants you have installed (Antigravity, Claude Code, OpenCode, Cline, Codex, etc.).
3. Automatically creates symlinks to ensure the skills are loaded by all of your agents.

### Manual Installation
If you prefer not to use the script, you can manually clone this repository into your AI's respective plugin or skill directory (e.g., `~/.gemini/config/plugins/` for Antigravity or `~/.claude/plugins/` for Claude Code).

*Note: Supported AIs will automatically trigger the appropriate skill when you mention keywords like `mikrotik`, `routeros`, or work within Laravel/Node.js project directories.*

## Contributing

Feel free to submit pull requests if you have improvements for RouterOS v7 mappings or specific framework integrations!
