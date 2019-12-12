#!/bin/bash
REPO_DIR="$(pwd)"
DEPLOY_DIR="$REPO_DIR/build"
ARTIFACT_PREFIX="ARTIFACTS:"

# Fail when any command fails
set -e

echo "Creating deploy directory: $DEPLOY_DIR"
mkdir -p "$DEPLOY_DIR"

cd $REPO_DIR

if [[ ! -f "Makefile" ]]; then
    echo "No Makefile found."
    continue
fi

ARTIFACTS=$(make | grep "$ARTIFACT_PREFIX")
ARTIFACTS=${ARTIFACTS#"$ARTIFACT_PREFIX"}
echo "Build artifacts: $ARTIFACTS"

for artifact in $(echo $ARTIFACTS | sed "s/,/ /g"); do
    cp "$REPO_DIR/$artifact" "$DEPLOY_DIR/$artifact"
done
