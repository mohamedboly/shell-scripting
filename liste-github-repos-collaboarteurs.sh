#!/bin/bash

# GitHub API URL
API_URL="https://api.github.com"

# GitHub username and personal access token
# `username` is the GitHub username, and `token` is the personal access token created in your GitHub account.
# These are sensitive credentials used to identify you on GitHub, so export them in your terminal before executing this script.
# Example:
# export username="your-username"
# export token="your-token"

# Retrieve username and token from environment variables
USERNAME=$username  # Ensure this is exported in the terminal before running the script
TOKEN=$token        # Ensure this is exported in the terminal before running the script

# Check if username and token are set
if [[ -z "$USERNAME" || -z "$TOKEN" ]]; then
  echo "Error: Username and/or token are not set. Please export them as environment variables before running the script."
  echo "Example: export username='your-username' && export token='your-token'"
  exit 1
fi

# User and Repository information
# This script expects two parameters during execution:
# 1. The GitHub organization or owner name
# 2. The repository name
REPO_OWNER=$1
REPO_NAME=$2

# Validate input arguments
if [[ -z "$REPO_OWNER" || -z "$REPO_NAME" ]]; then
  echo "Error: Missing required arguments."
  echo "Usage: $0 <repo-owner> <repo-name>"
  exit 1
fi

# Function to make a GET request to the GitHub API
function github_api_get {
  local endpoint="$1"
  local url="${API_URL}/${endpoint}"

  # Send a GET request to the GitHub API with authentication
  curl -s -u "${USERNAME}:${TOKEN}" "$url"
}

# Function to list users with read access to the repository
function list_users_with_read_access {
  local endpoint="repos/${REPO_OWNER}/${REPO_NAME}/collaborators"

  # Fetch the list of collaborators on the repository
  collaborators="$(github_api_get "$endpoint" | jq -r '.[] | select(.permissions.pull == true) | .login')"

  # Display the list of collaborators with read access
  if [[ -z "$collaborators" ]]; then
    echo "No users with read access found for ${REPO_OWNER}/${REPO_NAME}."
  else
    echo "Users with read access to ${REPO_OWNER}/${REPO_NAME}:"
    echo "$collaborators"
  fi
}

# Main script
echo "Listing users with read access to ${REPO_OWNER}/${REPO_NAME}..."
list_users_with_read_access
