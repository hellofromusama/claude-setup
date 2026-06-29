# Claude Code Setup (portable)

My personal Claude Code environment — skills, plugins, MCP servers, CLI tools, and the
multi-pipeline memory system — so I can reproduce it on any machine.

> **No secrets in this repo.** API keys, tokens, `.env` files, and credentials are never
> committed. claude.ai cloud connectors are tied to your account login, not to this repo.

## Quick start on a new machine

1. Install prerequisites (Node 18+, Python 3.11+, git). See [TOOLS.md](TOOLS.md).
2. Run the installer:
   - **Windows (PowerShell):** `./install.ps1`
   - **macOS / Linux / Git Bash:** `bash install.sh`
3. Sign in to Claude Code, then sign in to claude.ai connectors you want (see [MCP.md](MCP.md)).
4. Restart Claude Code so plugins + hooks load.

## What's in here

| File | What |
|------|------|
| [TOOLS.md](TOOLS.md) | Prereq CLIs (node, uv, bun, yt-dlp, ffmpeg) + how to install |
| [SKILLS.md](SKILLS.md) | Every skill/plugin + exact install command |
| [MCP.md](MCP.md) | MCP servers (claude.ai connectors + CLI-added) |
| [MEMORY.md](MEMORY.md) | The multi-pipeline memory system (graphify + claude-mem + claude-flow) |
| [install.ps1](install.ps1) / [install.sh](install.sh) | One-shot reproducible installer |

## Current inventory (snapshot)

- **Skills/plugins:** graphify, browser-harness, caveman, impeccable, gstack,
  vercel-agent-browser, claude-video (`watch`), codeburn, designer-skills (8),
  open-design, karpathy-guidelines, superpowers, code-review
- **CLI tools:** node 24, uv, bun 1.3, yt-dlp, graphify, browser-harness, codeburn, agent-browser
- **Memory:** 3 auto pipelines (claude-flow auto-memory · claude-mem · graphify) + curated `.md`
