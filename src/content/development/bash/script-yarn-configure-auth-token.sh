#!/bin/bash

#####################################################################################################################################################
# DESCRIPTION: 
#   Script to configure yarn with GitHub package registry authentication using a personal access token.
#   It prompts the user for a GitHub token and updates the ~/.npmrc file accordingly.
#   It also creates a backup of the existing ~/.npmrc file if it exists.
# USAGE: 
#   ./script-yarn-configure-auth-token.sh
# AUTHOR: 
#   Kaizten Analytics S.L. (development@kaizten.com)
#####################################################################################################################################################

# Prompt user for GitHub token
echo "✏️  Please enter your GitHub personal access token:"
read -s github_token

if [ -z "$github_token" ]; then
    echo "❌ GitHub token cannot be empty"
    exit 1
fi

echo "Configuring npm registry authentication..."

# Create or update ~/.npmrc file
NPMRC_FILE="$HOME/.npmrc"

# Create backup if file exists
if [ -f "$NPMRC_FILE" ]; then
    cp "$NPMRC_FILE" "$NPMRC_FILE.backup.$(date +%Y%m%d_%H%M%S)"
    echo "Backup created: $NPMRC_FILE.backup.$(date +%Y%m%d_%H%M%S)"
fi

# Remove existing entries for the same registry if they exist
if [ -f "$NPMRC_FILE" ]; then
    grep -v "//npm.pkg.github.com/:_authToken=" "$NPMRC_FILE" > "$NPMRC_FILE.tmp" || true
    grep -v "@kaizten:registry=" "$NPMRC_FILE.tmp" > "$NPMRC_FILE" || true
    rm -f "$NPMRC_FILE.tmp"
fi

# Add the new configuration
echo "//npm.pkg.github.com/:_authToken=$github_token" >> "$NPMRC_FILE"
echo "@kaizten:registry=https://npm.pkg.github.com/" >> "$NPMRC_FILE"

echo "✅ Successfully configured yarn/npm authentication for GitHub packages"
echo "Configuration added to: $NPMRC_FILE"
echo ""
echo "You can now install packages from @kaizten scope using:"
echo "  yarn add @kaizten/package-name"
echo "  npm install @kaizten/package-name"