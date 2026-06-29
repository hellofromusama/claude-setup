#!/usr/bin/env bash
# Claude Code setup installer (macOS / Linux / Git Bash). Re-run safe.
# Assumes Node, uv, git installed (see TOOLS.md).
set +e
SKILLS="$HOME/.claude/skills"
mkdir -p "$SKILLS"

echo "== prerequisites =="
npm install -g bun
npm install -g codeburn
npm install -g agent-browser
pip install --user -U yt-dlp 2>/dev/null || python3 -m pip install --user -U yt-dlp

echo "== uv tools =="
uv tool install graphifyy && graphify install
uv tool install browser-harness && browser-harness skill

echo "== npx installers =="
npx -y claude-mem install && npx claude-mem repair
npx -y impeccable install
npx -y "github:JuliusBrussee/caveman" -- --only claude --no-hooks --non-interactive

echo "== git-clone skills =="
[ -d "$SKILLS/watch" ]  || git clone --depth 1 https://github.com/bradautomates/claude-video.git "$SKILLS/watch"
[ -d "$SKILLS/gstack" ] || { git clone --single-branch --depth 1 https://github.com/garrytan/gstack.git "$SKILLS/gstack" && (cd "$SKILLS/gstack" && ./setup); }
[ -d "$SKILLS/karpathy-guidelines" ] || { git clone --depth 1 https://github.com/multica-ai/andrej-karpathy-skills.git /tmp/kp && cp -r /tmp/kp/karpathy-guidelines "$SKILLS/" && rm -rf /tmp/kp; }
if [ ! -d "$SKILLS/design-tokens" ]; then
  git clone --depth 1 https://github.com/julianoczkowski/designer-skills.git /tmp/dz
  for s in brief-to-tasks design-brief design-flow design-review design-tokens information-architecture; do cp -r "/tmp/dz/$s" "$SKILLS/$s"; done
  cp -r /tmp/dz/frontend-design "$SKILLS/designer-frontend-design"
  cp -r /tmp/dz/grill-me        "$SKILLS/designer-grill-me"
  rm -rf /tmp/dz
  echo "NOTE: edit name: in designer-frontend-design/SKILL.md + designer-grill-me/SKILL.md to match folder"
fi

echo "== MCP (local) =="
claude mcp add --scope user magic -- npx -y "@21st-dev/magic@latest"
claude mcp add --scope user nanobanana -- npx -y "@aeven/nanobanana-mcp@latest"

echo "Done. Restart Claude Code. See SKILLS.md / MCP.md / MEMORY.md for open-design, claude.ai connectors, and the graphify Stop hook."
