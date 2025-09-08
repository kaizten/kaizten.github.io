#!/bin/bash

#####################################################################################################################################################
# DESCRIPTION: 
#   It checks if the current system meets the minimum infrastructure requirements. 
# USAGE: 
#   ./script-infrastructure-checker.sh
# AUTHOR: 
#   Kaizten Analytics S.L. (development@kaizten.com)
#####################################################################################################################################################


# Required versions
MIN_UBUNTU_VERSION=24.4
MIN_JAVA_VERSION=17
MIN_MAVEN_VERSION=3.8.7
MIN_CURL_VERSION=8.5.0
MIN_GIT_VERSION=2.51.0
MIN_DOCKER_VERSION=28
MIN_DOCKER_COMPOSE_VERSION=2.27.0
MIN_YARN_VERSION=1.22.22
MIN_TSC_VERSION=5.9.2
MIN_PYTHON_VERSION=3.12.0

# This function splits the version numbers into arrays based on the '.' delimiter. It then compares each segment of the version numbers sequentially.
# If a segment in version1 is greater than the corresponding segment in version2, it returns 1. If a segment in version1 is less than the 
# corresponding segment in version2, it returns -1. If all segments are equal, it returns 0.
# 
# Arguments:
#   version1: The first version number to compare (e.g., "1.2.3").
#   version2: The second version number to compare (e.g., "1.2.4").
compare_versions() {
    local version1=$1
    local version2=$2
    # Split the version numbers into arrays
    IFS='.' read -r -a v1 <<< "$version1"
    IFS='.' read -r -a v2 <<< "$version2"
    # Get the maximum length of the two arrays
    local max_length=${#v1[@]}
    if [ ${#v2[@]} -gt $max_length ]; then
        max_length=${#v2[@]}
    fi
    # Compare each segment of the version numbers
    for ((i=0; i<$max_length; i++)); do
        local segment1=${v1[i]:-0} # Default to 0 if segment is missing
        local segment2=${v2[i]:-0} # Default to 0 if segment is missing
        if ((segment1 > segment2)); then
            echo 1
            return
        elif ((segment1 < segment2)); then
            echo -1
            return
        fi
    done
    echo 0
}

# Function to print status messages.
#
# Arguments:
#   $1: Status code (0 for success, 1 for failure)
#   $2: Message to display
check_status() {
    if [ $1 -eq 0 ]; then
        echo "✅ $2"
    else
        echo "❌ $2"
    fi
}

# Print minimum requirements
echo "📋 Requirements:"
echo "================"
echo "- Ubuntu version: $MIN_UBUNTU_VERSION (or higher)"
echo "- JDK version: $MIN_JAVA_VERSION (or higher)"
echo "- Maven version: $MIN_MAVEN_VERSION (or higher)"
echo "- curl version: $MIN_CURL_VERSION (or higher)"
echo "- Docker version: $MIN_DOCKER_VERSION (or higher)"
echo "- Docker Compose version: $MIN_DOCKER_COMPOSE_VERSION (or higher)"
echo "- Git version: $MIN_GIT_VERSION (or higher)"
echo "- Yarn version: $MIN_YARN_VERSION (or higher)"
echo "- TypeScript version: $MIN_TSC_VERSION (or higher)"
echo "- Python version: $MIN_PYTHON_VERSION (or higher)"
echo ""

echo "🧪 Tests:"
echo "========="

# Ubuntu version
test_name="Ubuntu version"
if [ -f /etc/os-release ]; then
    . /etc/os-release
    if [[ "$ID" == "ubuntu" ]]; then
        result=$(compare_versions "$VERSION_ID" "$MIN_UBUNTU_VERSION")
        if [ $result -eq 0 ]; then
            check_status 0 "$test_name: '$VERSION_ID' detected (= '$MIN_UBUNTU_VERSION')" 
        elif [ $result -eq 1 ]; then
            check_status 0 "$test_name: '$VERSION_ID' detected (> '$MIN_UBUNTU_VERSION')"
        else
            check_status 1 "$test_name: '$VERSION_ID' detected (needs '$MIN_UBUNTU_VERSION' or higher)"
        fi
    else
        check_status 1 "$test_name: it not an Ubuntu system (detected '$ID')"
    fi
else
    check_status 1 "$test_name: /etc/os-release not found"
fi

# JDK version
test_name="JDK version"
if command -v java &> /dev/null; then
    JAVA_VERSION=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}' | cut -d'.' -f1)
    result=$(compare_versions "$JAVA_VERSION" "$MIN_JAVA_VERSION")
    if [ $result -eq 0 ]; then
        check_status 0 "$test_name: '$JAVA_VERSION' detected (= '$MIN_JAVA_VERSION')"
    elif [ $result -eq 1 ]; then
        check_status 0 "$test_name: '$JAVA_VERSION' detected (> '$MIN_JAVA_VERSION')"
    else
        check_status 1 "$test_name: '$JAVA_VERSION' detected (needs '$MIN_JAVA_VERSION' or higher)"
    fi
else
    check_status 1 "$test_name: Java is not installed"
fi

# Maven installation
test_name="Maven installation"
if command -v mvn &> /dev/null; then
    check_status 0 "$test_name: installed"
else
    check_status 1 "$test_name: not installed"
fi

# Maven version
test_name="Maven version"
if command -v mvn &> /dev/null; then
    MAVEN_VERSION=$(mvn -v | awk '/Apache Maven/ {print $3}')
    result=$(compare_versions "$MAVEN_VERSION" "$MIN_MAVEN_VERSION")
    if [ $result -eq 0 ]; then
        check_status 0 "$test_name: '$MAVEN_VERSION' detected (= '$MIN_MAVEN_VERSION')"
    elif [ $result -eq 1 ]; then
        check_status 0 "$test_name: '$MAVEN_VERSION' detected (> '$MIN_MAVEN_VERSION')"
    else
        check_status 1 "$test_name: '$MAVEN_VERSION' detected (needs '$MIN_MAVEN_VERSION' or higher)"
    fi
else
    check_status 1 "$test_name: not installed"
fi

# curl installation
test_name="curl installation"
if command -v curl &> /dev/null; then
    check_status 0 "$test_name: installed"
else
    check_status 1 "$test_name: not installed"
fi

# curl version
test_name="curl version"
if command -v curl &> /dev/null; then
    CURL_VERSION=$(curl --version | awk '{print $2}' | head -n1)
    result=$(compare_versions "$CURL_VERSION" "$MIN_CURL_VERSION")
    if [ $result -eq 0 ]; then
        check_status 0 "$test_name: '$CURL_VERSION' detected (= '$MIN_CURL_VERSION')"
    elif [ $result -eq 1 ]; then
        check_status 0 "$test_name: '$CURL_VERSION' detected (> '$MIN_CURL_VERSION')"
    else
        check_status 1 "$test_name: '$CURL_VERSION' detected (needs '$MIN_CURL_VERSION' or higher)"
    fi
else
    check_status 1 "$test_name: not installed"
fi

# Docker installation
test_name="Docker installation"
if command -v docker &> /dev/null; then
    check_status 0 "$test_name: installed"
else
    check_status 1 "$test_name: not installed"
fi

# Docker does not require 'sudo' to run
test_name="Docker does not require 'sudo' to run"
if command -v docker &> /dev/null; then
    if docker info &> /dev/null; then
        check_status 0 "$test_name: it can be run without 'sudo'"
    else
        check_status 1 "$test_name: it cannot be run without 'sudo'"
    fi
else
    check_status 1 "$test_name: not installed"
fi

# Docker version
test_name="Docker version"
if command -v docker &> /dev/null; then
    DOCKER_VERSION=$(docker --version | awk '{print $3}' | sed 's/,//')
    result=$(compare_versions "$DOCKER_VERSION" "$MIN_UBUNTU_VERSION")
    if [ $result -eq 0 ]; then
        check_status 0 "$test_name: '$DOCKER_VERSION' detected (= '$MIN_DOCKER_VERSION')"
    elif [ $result -eq 1 ]; then
        check_status 0 "$test_name: '$DOCKER_VERSION' detected (> '$MIN_DOCKER_VERSION')"
    else
        check_status 1 "$test_name: '$DOCKER_VERSION' detected (needs '$MIN_DOCKER_VERSION' or higher)"
    fi
else
    check_status 1 "$test_name: not installed"
fi

# Docker Compose installation
test_name="Docker Compose installation"
if command -v docker-compose &> /dev/null; then
    check_status 0 "$test_name: installed"
else
    check_status 1 "$test_name: not installed" 
fi

# Docker Compose version
test_name="Docker Compose version"
if command -v docker-compose &> /dev/null; then
    DOCKER_COMPOSE_VERSION=$(docker compose version --short)    
    result=$(compare_versions "$DOCKER_COMPOSE_VERSION" "$MIN_DOCKER_COMPOSE_VERSION")
    if [ $result -eq 0 ]; then
        check_status 0 "$test_name: '$DOCKER_COMPOSE_VERSION' detected (= '$MIN_DOCKER_COMPOSE_VERSION')"
    elif [ $result -eq 1 ]; then
        check_status 0 "$test_name: '$DOCKER_COMPOSE_VERSION' detected (> '$MIN_DOCKER_COMPOSE_VERSION')"
    else
        check_status 1 "$test_name: '$DOCKER_COMPOSE_VERSION' detected (needs '$MIN_DOCKER_COMPOSE_VERSION' or higher)"
    fi
else
    check_status 1 "$test_name: not installed"
fi  

# Git installation
test_name="Git installation"
if command -v git &> /dev/null; then
    check_status 0 "$test_name: installed"
else
    check_status 1 "$test_name: not installed"
fi  

# Git version
test_name="Git version"
if command -v git &> /dev/null; then
    GIT_VERSION=$(git --version | awk '{print $3}')
    result=$(compare_versions "$GIT_VERSION" "$MIN_GIT_VERSION")
    if [ $result -eq 0 ]; then
        check_status 0 "$test_name: '$GIT_VERSION' detected (= '$MIN_GIT_VERSION')"
    elif [ $result -eq 1 ]; then
        check_status 0 "$test_name: '$GIT_VERSION' detected (> '$MIN_GIT_VERSION')"
    else
        check_status 1 "$test_name: '$GIT_VERSION' detected (needs '$MIN_GIT_VERSION' or higher)"
    fi
else
    check_status 1 "$test_name: not installed"
fi

# Git does not require 'sudo' to run
test_name="Git does not require 'sudo' to run"
if command -v git &> /dev/null; then
    if git config --global user.name &> /dev/null && git config --global user.email &> /dev/null; then
        check_status 0 "$test_name: it can be run without 'sudo'"
    else
        check_status 1 "$test_name: it cannot be run without 'sudo'"
    fi
else
    check_status 1 "$test_name: not installed"
fi

# Git can be used with ssh keys (if configured)
test_name="Git can be used with SSH keys"
if [ -f "$HOME/.ssh/id_rsa" ] || [ -f "$HOME/.ssh/id_ed25519" ]; then
    check_status 0 "$test_name: it can use SSH keys"
else
    check_status 1 "$test_name: it cannot use SSH keys"
fi

# Yarn installation
test_name="yarn installation"
if command -v yarn &> /dev/null; then
    check_status 0 "$test_name: installed"
else
    check_status 1 "$test_name: not installed"
fi

# Yarn does not require 'sudo' to run
test_name="yarn does not require 'sudo' to run"
if command -v yarn &> /dev/null; then
    if yarn --version &> /dev/null; then
        check_status 0 "$test_name: it can be run without 'sudo'"
    else
        check_status 1 "$test_name: it cannot be run without 'sudo'"
    fi
else
    check_status 1 "$test_name: not installed"
fi

# Yarn version
test_name="yarn version"
if command -v yarn &> /dev/null; then
    YARN_VERSION=$(yarn --version)
    result=$(compare_versions "$YARN_VERSION" "$MIN_YARN_VERSION")
    if [ $result -eq 0 ]; then
        check_status 0 "$test_name: '$YARN_VERSION' detected (= '$MIN_YARN_VERSION')"
    elif [ $result -eq 1 ]; then
        check_status 0 "$test_name: '$YARN_VERSION' detected (> '$MIN_YARN_VERSION')"
    else
        check_status 1 "$test_name: '$YARN_VERSION' detected (needs '$MIN_YARN_VERSION' or higher)"
    fi
else
    check_status 1 "$test_name: not installed"
fi

# TypeScript installation
test_name="TypeScript installation"
if command -v tsc &> /dev/null; then
    check_status 0 "$test_name: installed"
else
    check_status 1 "$test_name: not installed"
fi

# TypeScript version
test_name="TypeScript version"
if command -v tsc &> /dev/null; then
    TSC_VERSION=$(tsc --version | awk '{print $2}')
    result=$(compare_versions "$TSC_VERSION" "$MIN_TSC_VERSION")
    if [ $result -eq 0 ]; then
        check_status 0 "$test_name: '$TSC_VERSION' detected (= '$MIN_TSC_VERSION')"
    elif [ $result -eq 1 ]; then
        check_status 0 "$test_name: '$TSC_VERSION' detected (> '$MIN_TSC_VERSION')"
    else
        check_status 1 "$test_name: '$TSC_VERSION' detected (needs '$MIN_TSC_VERSION' or higher)"
    fi
else
    check_status 1 "$test_name: not installed"
fi

# Python installation
test_name="Python installation"
if command -v python3 &> /dev/null; then
    check_status 0 "$test_name: installed"
else
    check_status 1 "$test_name: not installed"
fi  

# Python version
test_name="Python version"
if command -v python3 &> /dev/null; then
    PYTHON_VERSION=$(python3 --version | awk '{print $2}')
    result=$(compare_versions "$PYTHON_VERSION" "$MIN_PYTHON_VERSION")
    if [ $result -eq 0 ]; then
        check_status 0 "$test_name: '$PYTHON_VERSION' detected (= '$MIN_PYTHON_VERSION')"
    elif [ $result -eq 1 ]; then
        check_status 0 "$test_name: '$PYTHON_VERSION' detected (> '$MIN_PYTHON_VERSION')"
    else
        check_status 1 "$test_name: '$PYTHON_VERSION' detected (needs '$MIN_PYTHON_VERSION' or higher)"
    fi
else
    check_status 1 "$test_name: not installed"
fi

# Add a summary at the end with the versions detected in the system
UBUNTU_SUMMARY="Ubuntu version: ${VERSION_ID:-Not detected}" # Default to 'Not detected' if not set
JAVA_SUMMARY="Java version: ${JAVA_VERSION:-Not detected}" # Default to 'Not detected' if not set
MAVEN_VERSION_SUMMARY="Maven version: ${MAVEN_VERSION:-Not detected}" # Default to 'Not detected' if not set
CURL_VERSION_SUMMARY="curl version: ${CURL_VERSION:-Not detected}" # Default to 'Not detected' if not set
DOCKER_VERSION_SUMMARY="Docker version: $(command -v docker &> /dev/null && docker --version | awk '{print $3}' | sed 's/,//' || echo Not detected)"
DOCKER_COMPOSE_VERSION_SUMMARY="Docker Compose version: $(command -v docker-compose &> /dev/null && docker compose version --short || echo Not detected)"
GIT_VERSION_SUMMARY="Git version: $(command -v git &> /dev/null && git --version | awk '{print $3}' || echo Not detected)"
YARN_VERSION_SUMMARY="Yarn version: $(command -v yarn &> /dev/null && yarn --version || echo Not detected)"
TSC_VERSION_SUMMARY="TypeScript version: $(command -v tsc &> /dev/null && tsc --version | awk '{print $2}' || echo Not detected)"
PYTHON_VERSION_SUMMARY="Python version: $(command -v python3 &> /dev/null && python3 --version | awk '{print $2}' || echo Not detected)"

# Print summary
echo ""
echo "📜 Summary:"
echo "==========="
echo "$UBUNTU_SUMMARY"
echo "$JAVA_SUMMARY"
echo "$MAVEN_VERSION_SUMMARY"
echo "$CURL_VERSION_SUMMARY"
echo "$DOCKER_VERSION_SUMMARY"
echo "$DOCKER_COMPOSE_VERSION_SUMMARY"
echo "$GIT_VERSION_SUMMARY"
echo "$YARN_VERSION_SUMMARY"
echo "$TSC_VERSION_SUMMARY"
echo "$PYTHON_VERSION_SUMMARY"