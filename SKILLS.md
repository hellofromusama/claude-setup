# Skills & Plugins — install commands

All install into the user scope (`~/.claude/skills/`, user plugins, or global CLIs), so they
work across every project on the machine.

## Via package managers / installers

| Name | What it does | Install |
|------|--------------|---------|
| **graphify** | folder → queryable knowledge graph | `uv tool install graphifyy && graphify install` |
| **browser-harness** | LLM-driven Chrome (CDP) automation | `uv tool install browser-harness && browser-harness skill` |
| **caveman** | terse/token-compressed responses | `npx -y github:JuliusBrussee/caveman -- --only claude --no-hooks --non-interactive` |
| **impeccable** | frontend design-quality skill | `npx -y impeccable install` |
| **claude-mem** | passive cross-session memory (daemon :37777) | `npx -y claude-mem install && npx claude-mem repair` |
| **codeburn** | AI token-cost dashboard | `npm install -g codeburn` |
| **vercel agent-browser** | Vercel browser-automation CLI | `npm install -g agent-browser` (skill: clone `vercel-labs/agent-browser/skills/agent-browser` → `~/.claude/skills/vercel-agent-browser`, rename frontmatter `name:` to `vercel-agent-browser`) |

> `graphifyy` (double-y) is the real PyPI name — `graphify` was taken. Publisher: captainturbo → repo safishamsi/graphify.

## Via git clone into `~/.claude/skills/`

```bash
# claude-video  (needs ffmpeg + yt-dlp)
git clone --depth 1 https://github.com/bradautomates/claude-video.git  ~/.claude/skills/watch

# gstack  (needs bun)
git clone --single-branch --depth 1 https://github.com/garrytan/gstack.git ~/.claude/skills/gstack \
  && (cd ~/.claude/skills/gstack && ./setup)

# karpathy guidelines
git clone --depth 1 https://github.com/multica-ai/andrej-karpathy-skills.git /tmp/karpathy \
  && cp -r /tmp/karpathy/karpathy-guidelines ~/.claude/skills/

# designer-skills  (8 skills; rename frontend-design/grill-me to avoid collisions)
git clone --depth 1 https://github.com/julianoczkowski/designer-skills.git /tmp/dz
for s in brief-to-tasks design-brief design-flow design-review design-tokens information-architecture; do
  cp -r /tmp/dz/$s ~/.claude/skills/$s; done
cp -r /tmp/dz/frontend-design ~/.claude/skills/designer-frontend-design   # edit SKILL.md name: -> designer-frontend-design
cp -r /tmp/dz/grill-me        ~/.claude/skills/designer-grill-me          # edit SKILL.md name: -> designer-grill-me
```

## Already-bundled / marketplace
- **superpowers** (`using-superpowers`, `superpowers-lab`) and **code-review** (`/code-review`) —
  ship with / installed via Claude Code's skill set; no manual install needed on a fresh Claude Code.

## open-design (desktop app + MCP) — see [MCP.md](MCP.md)
Download the desktop app from https://github.com/nexu-io/open-design/releases, then register its MCP:
`claude mcp add --scope user open-design -- node "<OpenDesignInstallDir>/resources/app/prebundled/daemon/daemon-cli.mjs" mcp`

## Global CLAUDE.md
Add this to `~/.claude/CLAUDE.md` so the Karpathy coding guidelines apply on every project:
> On every project, follow the Karpathy Guidelines for code work; invoke the `karpathy-guidelines` skill for non-trivial code.
