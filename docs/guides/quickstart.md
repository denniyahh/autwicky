# Quick Start

Get a wiki in your project in 3 commands.

## 1. Install (one-time)

```bash
uv tool install mkdocs --with mkdocs-material --with mkdocs-mermaid2-plugin --with mkdocs-panzoom-plugin
```

## 2. Scaffold

```bash
cd your-project
bash <(curl -s https://raw.githubusercontent.com/denniyahh/autwicky/main/install.sh)
```

Or locally, if you have the template:

```bash
bash ~/.hermes/templates/project-wiki/scripts/scaffold.sh
```

## 3. Preview

```bash
mkdocs serve -f docs/mkdocs.yml
```

Open http://localhost:8000.

## 4. Generate Content

Ask an LLM to populate the stub pages:

~~~~
Analyze this codebase and populate docs/ with:
- architecture/overview.md — component structure, design principles
- diagrams/system.md — C4 context diagram + key flow diagrams
- guides/quickstart.md — installation and first use

Use ```mermaid code blocks for all diagrams.
Limit 12 nodes per diagram, use subgraphs for grouping.
~~~~

## 5. Build

```bash
mkdocs build -f docs/mkdocs.yml
```

Output goes to `site/` (git-ignored). Serve with any static host.

---

## Optional: Deploy to GitHub Pages

If you want to publish your wiki publicly:

```bash
bash ~/.hermes/templates/project-wiki/scripts/deploy.sh
```

Builds the site and pushes to the `gh-pages` branch. The site will be live at `https://<user>.github.io/<repo>` within a minute. Requires `gh` CLI for auto-configuration (falls back gracefully without it).

## Diagram Tips

- **Too cluttered?** Click the diagram → expands to full viewport
- **Need more detail?** Scroll to zoom, drag to pan
- **Dark mode?** Auto-detected from your OS preference
- **Mermaid not rendering?** Check that `custom_fences` config is present in `mkdocs.yml`

## Prerequisites

- `mkdocs` (installed via `uv tool install` above)
- `git` (for repo URL detection)
- A project with a `README.md` (for description detection)
