#!/usr/bin/env bash
# Scaffold a MkDocs Material wiki for the current project.
# Run from the project root.

set -euo pipefail

TEMPLATE_DIR="${HERMES_TEMPLATES:-$HOME/.hermes/templates}/project-wiki/docs"
DOCS_DIR="${1:-$PWD/docs}"

if [ -d "$DOCS_DIR" ] && [ "$(ls -A "$DOCS_DIR" 2>/dev/null)" ]; then
    echo "⚠️  docs/ already exists and is not empty."
    echo "   Use --force to overwrite, or specify a different path."
    exit 1
fi

# Auto-detect project info
PROJECT_NAME=$(basename "$PWD")
REPO_URL=$(git remote get-url origin 2>/dev/null | sed 's|git@github.com:|https://github.com/|; s|\.git$||' || echo "null")
DESCRIPTION=$(head -5 README.md 2>/dev/null | grep -oP '^#\s+\K.*' | head -1 || echo "$PROJECT_NAME documentation")

echo "📦 Scaffolding wiki for: $PROJECT_NAME"
echo "   Repo: $REPO_URL"

# Create directory structure
mkdir -p "$DOCS_DIR"/{architecture,diagrams,guides}

# Copy and template files
for tmpl in "$TEMPLATE_DIR"/*.tmpl; do
    dest="$DOCS_DIR/$(basename "$tmpl" .tmpl)"
    sed -e "s|{{SITE_NAME}}|$PROJECT_NAME|g" \
        -e "s|{{SITE_DESCRIPTION}}|$DESCRIPTION|g" \
        -e "s|{{REPO_URL}}|$REPO_URL|g" \
        "$tmpl" > "$dest"
    echo "   ✓ $(basename "$dest")"
done

# Copy static files
if [ -f "$TEMPLATE_DIR/.gitignore" ]; then
    cp "$TEMPLATE_DIR/.gitignore" "$DOCS_DIR/"
    echo "   ✓ .gitignore"
fi

# Copy assets (CSS, JS)
if [ -d "$TEMPLATE_DIR/assets" ]; then
    cp -r "$TEMPLATE_DIR/assets" "$DOCS_DIR/"
    echo "   ✓ assets/"
fi

# Create stub pages
cat > "$DOCS_DIR/architecture/overview.md" << 'STUB'
# Architecture Overview

*Stub page — replace with generated content.*

Add your project's architecture documentation here:
- Crate/module structure
- Design principles
- Key components
STUB

cat > "$DOCS_DIR/diagrams/system.md" << 'STUB'
# System Architecture

*Stub page — replace with generated Mermaid diagrams.*

```mermaid
graph TD
    A[Component A] --> B[Component B]
    B --> C[Component C]
```
STUB

cat > "$DOCS_DIR/guides/quickstart.md" << 'STUB'
# Quick Start

*Stub page — replace with generated content.*

## Installation

```bash
# Add installation steps here
```

## Usage

```bash
# Add usage examples here
```
STUB

echo "   ✓ architecture/overview.md"
echo "   ✓ diagrams/system.md"
echo "   ✓ guides/quickstart.md"

echo ""
echo "✅ Wiki scaffolded at $DOCS_DIR/"
echo ""
echo "Next steps:"
echo "  1. Generate content with an LLM: 'Analyze this codebase and populate docs/ with architecture pages and Mermaid diagrams'"
echo "  2. Preview:  mkdocs serve -f docs/mkdocs.yml"
echo "  3. Build:    mkdocs build -f docs/mkdocs.yml"
