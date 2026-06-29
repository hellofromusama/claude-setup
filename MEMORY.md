# Multi-pipeline memory system

Four memory mechanisms run together. Three fire automatically on **session Stop**; one is curated.

| # | Pipeline | Trigger | Store | Notes |
|---|----------|---------|-------|-------|
| 1 | **Curated `.md`** | manual (by Claude, with judgment) | `~/.claude/projects/<proj>/memory/*.md` + `MEMORY.md` | source of truth; high signal. NOT auto — curation is the point |
| 2 | **claude-flow auto-memory** | Stop hook | claude-flow hybrid/HNSW store | `auto-memory-hook.mjs sync` (from claude-flow config) |
| 3 | **claude-mem** | continuous PostToolUse + worker | `~/.claude-mem` (SQLite + Chroma, worker :37777) | passive capture; `npx claude-mem start` if worker down |
| 4 | **graphify** | Stop hook (per-project) | `<project>/graphify-out/graph.json` | incremental `graphify update` (code-only, no-LLM); preserves doc/memory layer |

## graphify per-project Stop hook
`<project>/.claude/settings.json` (this file is gitignored locally — personal path):
```json
{
  "hooks": {
    "Stop": [
      { "hooks": [
        { "type": "command",
          "command": "cmd /c \"%USERPROFILE%\\.local\\bin\\graphify.exe\" update \"%CLAUDE_PROJECT_DIR%\"",
          "timeout": 60000, "statusMessage": "graphify: updating code graph" }
      ] }
    ]
  }
}
```
(macOS/Linux: `command: "graphify update \"$CLAUDE_PROJECT_DIR\""`.)

## Seeding a project's graphify graph
1. One-time full build at repo root: `cd <project> && /graphify .` (auto-skips node_modules/.git, honors .gitignore).
2. To enrich with external memory + git, stage them into a **non-gitignored** temp dir and run a full build, then delete the temp dir. (graphify honors `.gitignore`, so the staging folder must NOT be ignored, but staging code/doc copies you don't want should be.)
3. The Stop hook's `graphify update` keeps code fresh and preserves the doc/memory/git semantic layer.

## .gitignore entries for a project using graphify
```
graphify-out/
memory-experiment/
```

## Overlap note
Pipelines 2 (claude-flow) and 3 (claude-mem) both auto-capture sessions and don't coordinate —
redundant by design here. Disable one if you want less overhead:
- claude-flow: remove the `auto-memory-hook.mjs sync` Stop hook from `~/.claude/settings.json`
- claude-mem: `npx claude-mem stop` / uninstall, or disable its hooks
