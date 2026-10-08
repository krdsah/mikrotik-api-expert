# mcp_mikrotik.py
# An MCP (Model Context Protocol) Server to provide native Antigravity tools
# for testing MikroTik router accessibility.

import sys
try:
    from mcp.server.fastmcp import FastMCP
except ImportError:
    print("Error: The 'mcp' package is not installed. Please run: pip install mcp")
    sys.exit(1)

import socket
import json
import subprocess
import platform

# Initialize the MCP Server
mcp = FastMCP("Mikrotik Diagnostic Server")

@mcp.tool()
def test_mikrotik_accessibility(host: str) -> str:
    """
    Test standard MikroTik ports and ICMP ping to verify router accessibility.
    Use this tool whenever you need to check if a MikroTik router is online and which APIs are exposed.
    
    Args:
        host: The IP address or hostname of the MikroTik router.
    """
    results = {"Host": host, "Status": "Unknown"}
    ports = {
        "HTTP_REST (80)": 80, 
        "HTTPS_REST (443)": 443, 
        "Legacy_API (8728)": 8728, 
        "Legacy_API_SSL (8729)": 8729,
        "Winbox (8291)": 8291,
        "SSH (22)": 22
    }
    
    # 1. ICMP Ping Test
    param = '-n' if platform.system().lower() == 'windows' else '-c'
    try:
        ping_result = subprocess.run(
            ["ping", param, "1", host], 
            capture_output=True, 
            timeout=2
        )
        results["Ping"] = "Success" if ping_result.returncode == 0 else "Failed (No Route or ICMP Blocked)"
    except Exception as e:
        results["Ping"] = f"Failed to execute ping: {str(e)}"

    # 2. Port Tests
    open_ports = 0
    for name, port in ports.items():
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
            s.settimeout(1.0) # 1 second timeout for port scan
            result = s.connect_ex((host, port))
            if result == 0:
                results[name] = "Open"
                open_ports += 1
            else:
                results[name] = "Closed / Filtered"

    # Evaluate Overall Status
    if results["Ping"] == "Success" or open_ports > 0:
        results["Status"] = "Online"
    else:
        results["Status"] = "Offline / Unreachable"

    return json.dumps(results, indent=2)

if __name__ == "__main__":
    # Start the MCP server using standard input/output
    mcp.run()
