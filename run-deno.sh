#!/bin/bash

# GitLab MR MCP Server - Deno Runner with Network Restrictions
# This script runs the MCP server with Deno and restricts network access
# to only the specified GitLab domain.

# Check if GITLAB_DOMAIN is set
if [ -z "$GITLAB_DOMAIN" ]; then
    echo "Error: GITLAB_DOMAIN environment variable is not set."
    echo "Example: export GITLAB_DOMAIN=gitlab.transics-cicd.aws.zf.com"
    exit 1
fi

# Check if MR_MCP_GITLAB_TOKEN or GITLAB_PRIVATE_TOKEN is set
if [ -z "$MR_MCP_GITLAB_TOKEN" ] && [ -z "$GITLAB_PRIVATE_TOKEN" ]; then
    echo "Error: MR_MCP_GITLAB_TOKEN or GITLAB_PRIVATE_TOKEN environment variable is not set."
    exit 1
fi

# Run with Deno with strict network permissions
# Only allows network access to the specified GITLAB_DOMAIN
deno run \
  --allow-net="$GITLAB_DOMAIN" \
  --allow-env=MR_MCP_GITLAB_TOKEN,GITLAB_PRIVATE_TOKEN,MR_MCP_GITLAB_HOST,GITLAB_DOMAIN,MR_MCP_MIN_ACCESS_LEVEL,MR_MCP_PROJECT_SEARCH_TERM \
  index.js
