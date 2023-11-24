# Declarative Label Sync GitHub Action

## Description

This GitHub Action syncs labels from a YAML file to a target repository. Labels are declared in a YAML file, and this action automates the process of synchronizing them with the target repository.

## Inputs

| Name                  | Description                                               | Required | Default Value           |
|-----------------------|-----------------------------------------------------------|----------|-------------------------|
| `owner`               | Owner of the target repository.                           | Yes      | N/A                     |
| `repository`          | Target sync repository.                                   | Yes      | N/A                     |
| `token`               | GitHub token used to sync labels.                         | Yes      | N/A                     |
| `labels_declarations` | Location of the YAML file containing labels declarations. | Yes      | `./.github/labels.yaml` |

## Usage

Here's an example workflow that uses this GitHub Action:

```yaml
name: Sync

on:
  push:
    branches:
      - main

permissions: write-all

jobs:
  sync-labels:
    name: Labeles
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: shanduur/declarative-labels-sync-action@main
        with:
          owner: shanduur
          repository: ${{ github.event.repository.name }}
          token: ${{ secrets.GITHUB_TOKEN }}
```

This example workflow triggers the label synchronization on each push to the main branch.

Make sure to customize the inputs according to your needs.

## License

This GitHub Action is licensed under the [MIT License](LICENSE).
