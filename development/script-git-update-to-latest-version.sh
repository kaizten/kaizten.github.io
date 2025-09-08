#!/bin/bash

#####################################################################################################################################################
# DESCRIPTION: 
#   This script updates git to the latest version on an Ubuntu-based system. It checks the current version of git installed, and if it's not the 
#   latest, it downloads, compiles, and installs the latest version.
# USAGE:
#   ./script-github-update-to-latest-version.sh
# AUTHOR: 
#   Kaizten Analytics S.L. (development@kaizten.com)
#####################################################################################################################################################

# Define the git version as a constant
GIT_VERSION="2.51.0"

echo "🔄 Updating git to the latest version ($GIT_VERSION)"

# Check if git is already installed and its version
if command -v git &> /dev/null; then
    CURRENT_VERSION=$(git --version | awk '{print $3}')
    echo "📌 Current git version: $CURRENT_VERSION"
    if [ "$CURRENT_VERSION" == "$GIT_VERSION" ]; then
        echo "✅ Git is already at the latest version ($GIT_VERSION). No update needed."
        exit 0
    else
        echo "🔄 Updating git from version $CURRENT_VERSION to $GIT_VERSION"
    fi
else
    echo "❌ Git is not installed. Proceeding with installation of version $GIT_VERSION"
fi

# Add icons to dependency installation steps
echo "📦 Installing dependencies..."
sudo apt-get update -y

echo "📦 Installing dependencies for latest git version..."
sudo apt-get install build-essential
sudo apt-get install libexpat1-dev 
sudo apt-get install gettext 
sudo apt-get install libz-dev 
sudo apt-get install libssl-dev 
sudo apt-get install build-essential
sudo apt-get install libcurl4-openssl-dev
sudo apt-get install gettext
sudo apt-get install asciidoctor

# Update the wget command to use the constant
echo "⬇️ Downloading and installing latest git version..."
wget https://www.kernel.org/pub/software/scm/git/git-$GIT_VERSION.tar.gz

# Move .tar.gz to /opt directory
echo "📂 Moving git archive to /opt directory..."
sudo mv git-$GIT_VERSION.tar.gz /opt
cd /opt

# Update the tar command to use the constant
echo "📂 Extracting and removing git archive..."
tar -zxf git-$GIT_VERSION.tar.gz
rm git-$GIT_VERSION.tar.gz

echo "⚙️ Building and installing git..."
cd git-$GIT_VERSION/

echo "🔧 Configuring git..."
sudo make prefix=/usr install install-doc install-html install-info

echo "✅ Checking installed git version..."
git --version