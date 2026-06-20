#!/usr/bin/env bash
# autwicky — scaffold a MkDocs Material wiki in the current project.
# Usage: bash install.sh
set -euo pipefail

REPO="https://raw.githubusercontent.com/denniyahh/autwicky/main"
DOCS_DIR="${1:-$PWD/docs}"

if [ -d "$DOCS_DIR" ] && [ "$(ls -A "$DOCS_DIR" 2>/dev/null)" ]; then
    echo "⚠️  docs/ already exists and is not empty."
    echo "   Remove it first or specify a different path."
    exit 1
fi

echo "📦 autwicky — scaffolding wiki..."

# Download template files
mkdir -p "$DOCS_DIR"/{architecture,diagrams,guides,assets}

for file in mkdocs.yml index.md .gitignore; do
    curl -sSL "$REPO/template/docs/$file" -o "$DOCS_DIR/$file"
done

for file in extra.css extra.js; do
    curl -sSL "$REPO/template/docs/assets/$file" -o "$DOCS_DIR/assets/$file"
done

for dir in architecture diagrams guides; do
    case $dir in
        architecture) page="overview.md" ;;
        diagrams) page="system.md" ;;
        guides) page="quickstart.md" ;;
    esac
    curl -sSL "$REPO/template/docs/$dir/$page" -o "$DOCS_DIR/$dir/$page"
done

# Template the config with project info
PROJECT_NAME=$(basename "$PWD")
REPO_URL=$(git remote get-url origin 2>/dev/null | sed 's|git@github.com:|https://github.com/|; s|\.git$||' || echo "")
DESCRIPTION=$(head -5 README.md 2>/dev/null | grep -oP '^#\s+\K.*' | head -1 || echo "$PROJECT_NAME documentation")

sed -i "s|{{SITE_NAME}}|$PROJECT_NAME|g; s|{{SITE_DESCRIPTION}}|$DESCRIPTION|g; s|{{REPO_URL}}|$REPO_URL|g" "$DOCS_DIR/mkdocs.yml"
sed -i "s|{{SITE_NAME}}|$PROJECT_NAME|g; s|{{SITE_DESCRIPTION}}|$DESCRIPTION|g" "$DOCS_DIR/index.md"

echo ""
echo "✅ Wiki scaffolded at $DOCS_DIR/"
echo ""
echo "Next steps:"
echo "  1. Generate content: ask an LLM to populate docs/ with architecture pages + Mermaid diagrams"
echo "  2. Preview:         mkdocs serve -f docs/mkdocs.yml"
echo "  3. Build:           mkdocs build -f docs/mkdocs.yml"
