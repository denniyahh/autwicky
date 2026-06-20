# System

## Scaffold → Content → Build Pipeline

```mermaid
sequenceDiagram
    actor User
    participant CLI as install.sh
    participant FS as Filesystem
    participant LLM as AI Agent
    participant MkDocs as MkDocs Build
    participant Host as GitHub Pages

    User->>CLI: bash install.sh
    CLI->>CLI: detect project name, repo URL
    CLI->>FS: create docs/{architecture,diagrams,guides,assets}
    CLI->>FS: write mkdocs.yml (templated)
    CLI->>FS: write index.md (templated)
    CLI->>FS: write stub pages
    CLI->>FS: copy assets/{extra.css,extra.js}
    CLI-->>User: ✅ Scaffolded

    User->>LLM: "Populate docs/ with architecture pages and Mermaid diagrams"
    LLM->>FS: write architecture/overview.md
    LLM->>FS: write diagrams/system.md
    LLM->>FS: write guides/quickstart.md

    User->>MkDocs: mkdocs build
    MkDocs->>MkDocs: mermaid2 renders diagrams → SVG
    MkDocs->>MkDocs: panzoom wraps diagrams
    MkDocs->>MkDocs: extra.js attaches click handlers
    MkDocs->>FS: write site/

    User->>Host: deploy
    Host-->>User: 🌐 Wiki live
```

## Mermaid Rendering Pipeline

```mermaid
flowchart LR
    subgraph Source
        MD["```mermaid<br/>C4Context<br/>  Person(...)<br/>```"]
    end

    subgraph "MkDocs Processing"
        SF["superfences<br/>intercepts mermaid blocks"]
        M2["mermaid2 plugin<br/>calls mermaid.initialize()"]
        CFG["Config applied<br/>rankSpacing, nodeSpacing,<br/>wrappingWidth, fontSize"]
    end

    subgraph "Browser"
        SVG["SVG rendered"]
        PZ["panzoom<br/>scroll-zoom + drag-pan"]
        EX["extra.js<br/>click → .expanded class"]
    end

    MD --> SF --> M2 --> CFG --> SVG --> PZ --> EX
```

## Feature Matrix

| Feature | Without autwicky | With autwicky |
|---------|-----------------|---------------|
| MkDocs setup | Read docs, write mkdocs.yml manually | `bash install.sh` |
| Mermaid diagrams | Configure superfences + plugin manually | Built into template |
| Zoom/pan | None (static SVGs) | Panzoom plugin |
| Expand to viewport | None (squint at small diagrams) | Click → fullscreen |
| Dark mode | Manual config | Auto-detected |
| Diagram defaults | Mermaid built-ins (tight spacing) | `rankSpacing: 60`, `nodeSpacing: 40` |
| Project-specific config | Manual | Auto-detected from git + README |
