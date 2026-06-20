# autwicky

**Auto-documentation wiki system.** One command to scaffold a beautiful, interactive MkDocs Material wiki with Mermaid diagrams, pan/zoom, and click-to-expand — for any project.

## What You Get

- **MkDocs Material** — dark/light mode, tabs, search, syntax highlighting
- **Mermaid diagrams** — C4, flowcharts, sequences, state diagrams, class diagrams
- **Pan & zoom** — scroll to zoom, drag to pan on all diagrams
- **Click-to-expand** — click any diagram to fill the viewport, Esc to collapse
- **Auto-detection** — project name, repo URL, and description pulled from git + README

## Quick Start

```bash
# 1. Install mkdocs + plugins (one-time)
uv tool install mkdocs --with mkdocs-material --with mkdocs-mermaid2-plugin --with mkdocs-panzoom-plugin

# 2. Scaffold in any project
cd your-project
bash <(curl -s https://raw.githubusercontent.com/denniyahh/autwicky/main/install.sh)

# 3. Preview
mkdocs serve -f docs/mkdocs.yml     # http://localhost:8000
```

## How It Works

```
your-project/
├── docs/
│   ├── mkdocs.yml          ← Configured with mermaid2 + panzoom + expand
│   ├── index.md            ← Home page (auto-populated)
│   ├── assets/
│   │   ├── extra.css       ← Click-to-expand styles
│   │   └── extra.js        ← Click handler + Esc key
│   ├── architecture/
│   │   └── overview.md     ← Stub
│   ├── diagrams/
│   │   └── system.md       ← Stub (with starter Mermaid diagram)
│   └── guides/
│       └── quickstart.md   ← Stub
└── site/                   ← Built output (git-ignored)
```

After scaffolding, use an LLM to populate the stub pages with actual content and Mermaid diagrams. The system handles rendering, zoom, and expand.

## Mermaid Prompt Guidelines

When generating diagrams via LLM, include these constraints:

```
Mermaid diagram rules — follow strictly:
- Max 12 nodes per diagram. Split complex architectures across multiple focused diagrams.
- Keep node labels under 30 characters. Use <br/> for multi-line labels.
- Use subgraphs for logical grouping instead of separate nodes.
- Prefer LR (left-to-right) for wide diagrams, TB (top-to-bottom) for layered ones.
- For C4 diagrams: limit to one system boundary, max 5 containers, max 3 external systems.
- For sequence diagrams: limit to 5 participants, max 10 interactions.
- Avoid crossing edges — if unavoidable, split the diagram.
```

## Features

| Feature | Implementation |
|---------|---------------|
| Theme | MkDocs Material (dark/light auto) |
| Diagrams | Mermaid.js via mermaid2 plugin |
| Zoom | Panzoom plugin (scroll-zoom, drag-pan) |
| Expand | Custom CSS/JS (click diagram → full viewport) |
| Search | Built-in full-text search |
| Navigation | Tabs, sidebar, table of contents |
| Code | Syntax highlighting + copy button |

## Mermaid Renderer Config

The system configures Mermaid with better spacing defaults to reduce clutter:

```yaml
flowchart:
  rankSpacing: 60    # More vertical room
  nodeSpacing: 40    # More horizontal room
  wrappingWidth: 200 # Auto-wrap labels
  curve: basis       # Smoother edges
fontSize: 14         # Slightly smaller, less overlap
```

## Dogfood

This repo's own wiki is built with autwicky: `mkdocs serve -f docs/mkdocs.yml`

## License

MIT
