#!/bin/bash
set -e

echo "================================================="
echo " Installing MikroTik Expert Bundle for AI Agents "
echo "================================================="

# Central installation directory
BASE_DIR="$HOME/.mikrotik-ai-expert"
REPO_URL="https://github.com/username/mikrotik-api-expert.git"

# Clone or update the base repository
if [ -d "$BASE_DIR" ]; then
    echo "=> Updating existing repository at $BASE_DIR..."
    cd "$BASE_DIR"
    git pull origin main
else
    echo "=> Cloning repository into $BASE_DIR..."
    git clone "$REPO_URL" "$BASE_DIR"
fi

echo "=> Linking skills to supported AI assistants..."

# Define potential AI agent plugin/skill directories
TARGET_DIRS=(
    "$HOME/.gemini/config/plugins"          # Antigravity (Gemini)
    "$HOME/.claude/plugins"                 # Claude Code
    "$HOME/.config/claude/plugins"          # Claude Code (Alt)
    "$HOME/.opencode/plugins"               # OpenCode
    "$HOME/.command-code/plugins"           # Command Code
    "$HOME/.codex/plugins"                  # Codex
    "$HOME/.config/cline/skills"            # Cline
    "$HOME/.agents/plugins"                 # Generic AI Agents
)

INSTALLED_COUNT=0

for DIR in "${TARGET_DIRS[@]}"; do
    # Only install if the parent AI tool directory actually exists (so we don't pollute the home folder)
    # OR if it's the Antigravity folder (since we know we want that one always)
    PARENT_DIR=$(dirname "$DIR")
    if [ -d "$PARENT_DIR" ] || [[ "$DIR" == *".gemini"* ]]; then
        mkdir -p "$DIR"
        
        # Create a symlink to the central repo
        LINK_PATH="$DIR/mikrotik-expert-bundle"
        
        if [ -L "$LINK_PATH" ]; then
            rm "$LINK_PATH"
        elif [ -d "$LINK_PATH" ]; then
            rm -rf "$LINK_PATH"
        fi
        
        ln -s "$BASE_DIR" "$LINK_PATH"
        echo "   [✓] Linked to $LINK_PATH"
        INSTALLED_COUNT=$((INSTALLED_COUNT + 1))
    fi
done

echo ""
echo "================================================="
echo " Installation Complete! "
echo "================================================="
echo "The bundle was successfully installed and linked to $INSTALLED_COUNT AI assistant(s)."
echo "Please restart your AI agent(s) (Antigravity, Claude Code, OpenCode, etc.) to load the new skills."
