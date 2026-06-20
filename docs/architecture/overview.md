# Architecture Overview

autwicky is a template-driven system that scaffolds MkDocs Material wikis. It has three layers: template, scaffold, and render.

## System Components

```mermaid
flowchart TB
    subgraph Template["template/ — The Blueprint"]
        MK["mkdocs.yml<br/>Mermaid + panzoom + expand config"]
        CSS["extra.css<br/>Click-to-expand styles"]
        JS["extra.js<br/>Click handler + Esc key"]
        STUBS["Stub pages<br/>architecture/, diagrams/, guides/"]
    end

    subgraph Scaffold["Scaffold Layer"]
        DETECT["Auto-detect<br/>project name, repo URL, description"]
        COPY["Copy + template<br/>fill {{PLACEHOLDERS}}"]
        SCRIPT["install.sh<br/>curl-based installer"]
    end

    subgraph Render["Render Layer"]
        MKMATERIAL["MkDocs Material<br/>theme + navigation + search"]
        MERMAID2["mermaid2 plugin<br/>SVG diagram rendering"]
        PANZOOM["panzoom plugin<br/>scroll-zoom + drag-pan"]
        EXPAND["Expand CSS/JS<br/>click → full viewport"]
    end

    Template --> Scaffold
    Scaffold --> Render
```

## Three-Layer Design

| Layer | What | Where |
|-------|------|-------|
| **Template** | mkdocs.yml + assets + stubs | `template/docs/` |
| **Scaffold** | Detection + copy + placeholder fill | `install.sh` (local) or `scaffold.sh` (template) |
| **Render** | MkDocs + plugins at build time | `mkdocs build` |

## Plugin Stack

```mermaid
flowchart LR
    MD["Markdown source"]
    MD --> SF["pymdownx.superfences<br/>intercepts ```mermaid"]
    SF --> M2["mermaid2 plugin<br/>renders → SVG"]
    M2 --> PZ["panzoom plugin<br/>adds zoom/pan controls"]
    PZ --> EX["extra.js<br/>click-to-expand"]
    EX --> HTML["Static HTML site"]
```

## Why MkDocs Material?

| Requirement | Solution |
|-------------|----------|
| Human-readable | Material theme, navigation, search |
| Mermaid diagrams | mermaid2 plugin with superfences integration |
| Zoomable diagrams | Panzoom plugin (native MkDocs plugin) |
| Expand to viewport | Custom CSS/JS (20 lines) |
| Dark/light mode | Material palette auto-detection |
| Code blocks | Syntax highlighting + copy button |
| Git-native | Markdown files versioned alongside code |
| LLM-friendly | Markdown is the easiest format for agents to generate |
