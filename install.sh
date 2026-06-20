#!/usr/bin/env bash
# Install the autwicky project-wiki template to ~/.hermes/templates/
# Works both locally (rsync from repo) and via curl pipe (downloads tarball).
set -euo pipefail

TEMPLATES_DIR="${HOME}/.hermes/templates/project-wiki"
REPO="denniyahh/autwicky"
BRANCH="main"

echo "📦 Installing autwicky project-wiki template..."

# Determine template source
SCRIPT_DIR="$(cd "$(dirname "$0")" 2>/dev/null && pwd)"
LOCAL_TEMPLATE="${SCRIPT_DIR}/template"

if [ -d "$LOCAL_TEMPLATE" ]; then
    echo "   (using local copy)"
    mkdir -p "${TEMPLATES_DIR}"
    rsync -av --delete "${LOCAL_TEMPLATE}/" "${TEMPLATES_DIR}/"
else
    echo "   (downloading from GitHub...)"
    WORKDIR="$(mktemp -d)"
    trap 'rm -rf "$WORKDIR"' EXIT
    curl -sL "https://api.github.com/repos/${REPO}/tarball/${BRANCH}" | \
        tar xz -C "$WORKDIR" --strip-components=1
    mkdir -p "${TEMPLATES_DIR}"
    rsync -av --delete "${WORKDIR}/template/" "${TEMPLATES_DIR}/"
fi

echo ""
echo "✅ Template installed to ${TEMPLATES_DIR}"
echo ""
echo "Use it in any project:"
echo "  cd your-project"
echo "  bash ${HOME}/.hermes/templates/project-wiki/scripts/scaffold.sh"
