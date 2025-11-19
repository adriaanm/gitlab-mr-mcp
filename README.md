[![MseeP.ai Security Assessment Badge](https://mseep.net/pr/kopfrechner-gitlab-mr-mcp-badge.png)](https://mseep.ai/app/kopfrechner-gitlab-mr-mcp)

[![GitHub stars](https://img.shields.io/github/stars/kopfrechner/gitlab-mr-mcp?style=flat)](https://github.com/kopfrechner/gitlab-mr-mcp/stargazers)
[![License](https://img.shields.io/github/license/kopfrechner/gitlab-mr-mcp)](LICENSE)
[![smithery badge](https://smithery.ai/badge/@kopfrechner/gitlab-mr-mcp)](https://smithery.ai/server/@kopfrechner/gitlab-mr-mcp)

# 🚀 GitLab MR MCP

A Model Context Protocol (MCP) server for interacting with GitLab merge requests and issues.

## 📌 Overview

This project implements a server using the Model Context Protocol (MCP) that allows AI agents to interact with GitLab repositories. It provides tools for:

- Listing available GitLab projects
- Fetching merge request details and comments
- Getting merge request diffs
- Adding comments to merge requests
- Adding line-specific comments to code in merge request diffs
- Fetching issue details
- Setting merge request title and description

## 📦 Installation

### 🔒 Secure Installation with Deno (Recommended)

This installation method uses Deno to restrict network access to only your GitLab domain, providing better security isolation.

#### 🔧 Prerequisites

- [Deno](https://deno.land/) installed (`curl -fsSL https://deno.land/install.sh | sh`)
- GitLab access token with API access
- Your GitLab domain (e.g., `gitlab.transics-cicd.aws.zf.com`)

#### 📖 Setup

1. Clone this repository
2. Set environment variables:

```bash
export GITLAB_DOMAIN="gitlab.transics-cicd.aws.zf.com"  # Your GitLab domain
export GITLAB_PRIVATE_TOKEN="your_gitlab_token"  # Or use MR_MCP_GITLAB_TOKEN
```

3. Add the following to your MCP client configuration:
```json
{
  "mcpServers": {
    "gitlab-mr-mcp": {
      "command": "/path/to/gitlab-mr-mcp/run-deno.sh",
      "env": {
        "GITLAB_PRIVATE_TOKEN": "your_gitlab_token",
        "GITLAB_DOMAIN": "gitlab.transics-cicd.aws.zf.com"
      }
    }
  }
}
```

**Security Note:** The Deno runtime restricts network access to ONLY the domain specified in `GITLAB_DOMAIN`, preventing the server from accessing any other network resources.

### ⚡ Using Smithery

To install GitLab MR MCP for Claude Desktop automatically via Smithery:

```bash
npx -y @smithery/cli@latest install @kopfrechner/gitlab-mr-mcp --client claude --config '"{\"gitlabMrMcpToken\":\"YOUR_GITLAB_TOKEN\", \"gitlabMrMcpHost\": \"YOUR_GITLAB_HOST\"}"'
```

### 🛠️ Manual Installation (Node.js)

#### 🔧 Prerequisites

- Node.js
- GitLab access token with API access
- GitLab project ID(s)

#### 📖 Setup

1. Clone this repository
2. Install dependencies:

```bash
npm install
```

3. Add the following to your MCP client configuration:
```json
{
  "mcpServers": {
    "gitlab-mr-mcp": {
      "command": "node",
      "args": ["/path/to/gitlab-mr-mcp/index.js"],
      "env": {
        "MR_MCP_GITLAB_TOKEN": "your_gitlab_token",
        "MR_MCP_GITLAB_HOST": "your_gitlab_host"
      }
    }
  }
}
```

**Note:** The code is compatible with both Node.js and Deno runtimes.

## 🛠️ Available Tools

* `get_projects`
  Gets a list of GitLab projects accessible with your token.

* `list_open_merge_requests`
  Lists all open merge requests in the specified project.

* `get_merge_request_details`
  Gets detailed information about a specific merge request.

* `get_merge_request_comments`
  Gets comments from a specific merge request, including discussion notes and diff notes.

* `add_merge_request_comment`
  Adds a general comment to a merge request.

* `add_merge_request_diff_comment`
  Adds a comment to a specific line in a file within a merge request.

* `get_merge_request_diff`
  Gets the diff for a merge request.

* `get_issue_details`
  Gets detailed information about a specific issue.

* `set_merge_request_title`
  Set the title of a merge request

* `set_merge_request_description`
  Set the description of a merge request

## 🏗️ Development

### 🔍 Running Inspector

Set up environment variables:

```bash
export MR_MCP_GITLAB_TOKEN=your_gitlab_token
export MR_MCP_GITLAB_HOST=your_gitlab_host

# Optional evn vars to filter the projects the `get_projects` tool has access to:
# https://docs.gitlab.com/api/access_requests/#valid-access-levels
export MR_MCP_MIN_ACCESS_LEVEL=min_access_level
# Search term that should match the project path or name 
export MR_MCP_PROJECT_SEARCH_TERM=term 
```

For use with MCP clients, you can run:

```bash
npx -y @modelcontextprotocol/inspector npm start
```

## 🛠️ Troubleshooting

If you encounter permissions issues (403 Forbidden), check:

1. Your GitLab token has the proper scopes (api, read_api)
2. The token user has proper access to the projects
3. The project IDs are correct

## 📜 License

[MIT](LICENSE)

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

