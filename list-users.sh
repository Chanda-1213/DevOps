#!/bin/bash

#!/bin/bash

# GitHub API URL
API_URL="https://api.github.com"

# GitHub username and personal access token
USERNAME=$
TOKEN=$

# User and Repository information
REPO_OWNER=$1
REPO_NAME=$2

# Function to make a GET request to the GitHub API
function github_api_get {
    local endpoint="$1"
    local url="${API_URL}/${endpoint}"

    # Send a GET request to the GitHub API with authentication
    curl -s -u "${USERNAME}:${TOKEN}" "$url"
}

# Function to check if the repository exists
function check_repo_existence {
    local endpoint="repos/${REPO_OWNER}/${REPO_NAME}"

    # Fetch the repository information
    response="$(github_api_get "$endpoint")"

    # Check if the repository exists
    if echo "$response" | jq -e '.message == "Not Found"' > /dev/null; then
        echo "Repository ${REPO_OWNER}/${REPO_NAME} not found or you do not have access."
        exit 1
    fi
}

# Function to list users with read access to the repository
function list_users_with_read_access {
    local endpoint="repos/${REPO_OWNER}/${REPO_NAME}/collaborators"

    # Fetch the list of collaborators on the repository
    response="$(github_api_get "$endpoint")"

    # Print the raw JSON response for debugging
    echo "Raw response from GitHub API:"
    echo "$response"

    # Parse the response and extract collaborators with read access
    collaborators="$(echo "$response" | jq -r '.[] | select(.permissions.pull == true) | .login')"

    # Display the list of collaborators with read access
    if [[ -z "$collaborators" ]]; then
        echo "No users with read access found for ${REPO_OWNER}/${REPO_NAME}."
    else
        echo "Users with read access to ${REPO_OWNER}/${REPO_NAME}:"
        echo "$collaborators"
    fi
}

# Main script
if [[ -z "$REPO_OWNER" || -z "$REPO_NAME" ]]; then
    echo "Usage: $0 <repo_owner> <repo_name>"
    exit 1
fi

echo "Checking if repository ${REPO_OWNER}/${REPO_NAME} exists..."
check_repo_existence

echo "Listing users with read access to ${REPO_OWNER}/${REPO_NAME}..."
list_users_with_read_access
