# Azure Pipelines to GitHub Actions Migration

Automate the migration of Azure DevOps Pipelines to GitHub Actions using GitHub Actions Importer.

## Overview

This project demonstrates a practical approach for migrating Azure DevOps (ADO) CI/CD pipelines to GitHub Actions using the GitHub Actions Importer CLI.

The migration workflow includes:

- Installing GitHub Actions Importer
- Configuring GitHub and Azure DevOps credentials
- Identifying Azure Pipeline IDs
- Generating GitHub Actions workflows with dry-run mode
- Debugging and refining migrated workflows
- Replacing Azure-specific tasks with GitHub-native actions

## Architecture

Azure DevOps Pipeline
↓
GitHub Actions Importer
↓
Generated GitHub Workflow
↓
Validation & Refactoring
↓
Production GitHub Actions Workflow

## Prerequisites

### GitHub CLI

Install GitHub CLI:

```bash
gh --version
```

### GitHub Actions Importer

```bash
gh extension install github/gh-actions-importer
```

Verify installation:

```bash
gh actions-importer -h
```

### Personal Access Tokens (PATs)

Required:

- GitHub PAT
- Azure DevOps PAT

## Configuration

Run:

```bash
gh actions-importer configure
```

Example generated file:

```env
AZURE_DEVOPS_ACCESS_TOKEN=<ADO_PAT>
AZURE_DEVOPS_INSTANCE_URL=https://dev.azure.com
AZURE_DEVOPS_ORGANIZATION=<ORG_NAME>
AZURE_DEVOPS_PROJECT=<PROJECT_NAME>

GITHUB_ACCESS_TOKEN=<GITHUB_PAT>
GITHUB_INSTANCE_URL=https://github.com
```

## Finding Azure Pipeline ID

1. Open Azure DevOps
2. Navigate to Pipelines
3. Open target pipeline
4. Click Edit
5. Extract `pipelineId` from URL

Example:

```text
https://dev.azure.com/org/project/_apps/hub/ms.vss-build-web.ci-designer-hub?pipelineId=12270
```

Pipeline ID:

```text
12270
```

## Generate GitHub Workflow

```bash
gh actions-importer dry-run azure-devops pipeline \
--pipeline-id 12270 \
--output-dir .github/workflows_migration
```

## Recommended Improvements

### Python Setup

Replace Azure DevOps:

```yaml
- task: UsePythonVersion@0
```

With GitHub Actions:

```yaml
- name: Setup Python
  uses: actions/setup-python@v5
  with:
    python-version: "3.11"
```

### UV Package Manager

Install UV:

```yaml
- name: Install uv
  uses: astral-sh/setup-uv@v7
  with:
    version: "0.10.7"
```

### Checkout Repository

```yaml
- uses: actions/checkout@v4
```

## Common Migration Issues

### UsePythonVersion@0

Replace with:

```yaml
actions/setup-python
```

### AzureCLI@2

Requires manual mapping to GitHub Actions equivalents.

### Missing UV

Error:

```text
uv: command not found
```

Fix:

```yaml
- uses: astral-sh/setup-uv@v7
```

## Workflow Validation

Review:

- Generated logs
- WARN messages
- Failed task conversions
- Authentication configuration
- Runner dependencies

## Best Practices

- Use dry-run before migration.
- Validate generated YAML manually.
- Keep migration logs.
- Replace Azure-specific tasks with native GitHub actions.
- Pin action versions.
- Use GitHub Copilot for workflow refinement.

## References

- GitHub Actions Importer
- GitHub Actions
- Azure DevOps Pipelines
- Actions Setup Python
- Astral UV

## License

MIT
