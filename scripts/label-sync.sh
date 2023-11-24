#!/usr/bin/env bash
set -e

# Check if environment variables are set
if [ -z "${LABELER_TOKEN}" ] || [ -z "${REPO}" ] || [ -z "${OWNER}" ] || [ -z "${LABELS_YAML}" ]; then
  echo "ERROR: Please set the required input variables:"
  echo "- owner: Owner of the repository."
  echo "- repository: Target sync repository."
  echo "- token: GitHub token used to sync labels."
  echo "- labels_declarations: Location of YAML file containing labels declarations. (default: ./.github/labels.yaml)"
  exit 1
fi

# Get the latest stable release of labeler from GitHub
latest_release=$(curl -fsSL "https://api.github.com/repos/shanduur/labeler/releases/latest" | jq -r .tag_name)
echo "Latest release: ${latest_release}"

# Set OS and ARCH based on the environment
if [[ "$(uname)" == "Darwin" ]]; then
  OS="Darwin"
else
  OS="Linux"
fi

if [[ "$(uname -m)" == "x86_64" ]]; then
  ARCH="x86_64"
else
  ARCH="arm64"
fi

echo "OS: ${OS}, ARCH: ${ARCH}"

# Download the artifact
artifact_url="https://github.com/shanduur/labeler/releases/download/${latest_release}/labeler_${OS}_${ARCH}.tar.gz"
echo "Downloading artifact from ${artifact_url}"
curl -fsSL -o labeler.tar.gz "${artifact_url}"

# Create ./bin directory if it doesn't exist
mkdir -p ./bin

# Extract the artifact to the ./bin directory
echo "Extracting artifact to ./bin directory"
tar -xzf labeler.tar.gz -C ./bin

# Clean up downloaded tarball
rm labeler.tar.gz

echo "Artifact downloaded and extracted successfully to ./bin directory."

labeler="$(pwd)/bin/labeler"

"${labeler}" upload --owner "${OWNER}" --repo "${REPO}" "${LABELS_YAML}"
