# autwicky

**Auto-documentation wiki system.** Scaffold a beautiful MkDocs Material wiki for any project in one command.

## What It Does

```mermaid
flowchart LR
    A[Your Project] -->|"bash install.sh"| B[docs/ scaffolded]
    B -->|"LLM generates content"| C[Mermaid diagrams + pages]
    C -->|"mkdocs build"| D[Static wiki site]
    D -->|"deploy"| E[GitHub Pages / Vercel]
```

## Quick Links

- [System Architecture](architecture/overview.md) — How the pieces fit together
- [Pipeline Design](diagrams/system.md) — Scaffold → content → build → deploy flow
- [Quick Start](guides/quickstart.md) — Install and use in 3 commands

## Key Design Decisions

- **MkDocs Material** — Battle-tested static site generator, 50K+ users
- **Mermaid.js** — Text-based diagrams that render natively on GitHub
- **Panzoom plugin** — Scroll to zoom, drag to pan on all diagrams
- **Click-to-expand** — Custom CSS/JS: click diagram → full viewport, Esc to collapse
- **Template-driven** — All config lives in `template/`, no per-project config needed
- **LLM-agnostic** — Content generation is a separate step; use any LLM you prefer
