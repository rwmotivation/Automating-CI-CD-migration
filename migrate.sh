#!/bin/bash

set -e

PIPELINE_ID=$1

if [ -z "$PIPELINE_ID" ]; then
  echo "Usage: ./migrate.sh <pipeline-id>"
  exit 1
fi

echo "Running GitHub Actions Importer..."

gh actions-importer dry-run azure-devops pipeline \
--pipeline-id "$PIPELINE_ID" \
--output-dir .github/workflows_migration

echo "Migration completed."
