# Claude Code setup installer (Windows / PowerShell)
# Re-run safe. Assumes Node, uv, and git are installed (see TOOLS.md).
$ErrorActionPreference = "Continue"
$skills = "$env:USERPROFILE\.claude\skills"
New-Item -ItemType Directory -Force -Path $skills | Out-Null

Write-Host "== prerequisites ==" -ForegroundColor Cyan
npm install -g bun
npm install -g codeburn
npm install -g agent-browser
pip install --user -U yt-dlp

Write-Host "== uv tools ==" -ForegroundColor Cyan
uv tool install graphifyy;  graphify install
uv tool install browser-harness;  browser-harness skill

Write-Host "== npx installers ==" -ForegroundColor Cyan
npx -y claude-mem install;  npx claude-mem repair
npx -y impeccable install
npx -y "github:JuliusBrussee/caveman" -- --only claude --no-hooks --non-interactive

Write-Host "== git-clone skills ==" -ForegroundColor Cyan
if (-not (Test-Path "$skills\watch"))  { git clone --depth 1 https://github.com/bradautomates/claude-video.git "$skills\watch" }
if (-not (Test-Path "$skills\gstack")) { git clone --single-branch --depth 1 https://github.com/garrytan/gstack.git "$skills\gstack"; Push-Location "$skills\gstack"; bash ./setup; Pop-Location }
if (-not (Test-Path "$skills\karpathy-guidelines")) {
  git clone --depth 1 https://github.com/multica-ai/andrej-karpathy-skills.git "$env:TEMP\kp"
  Copy-Item -Recurse -Force "$env:TEMP\kp\karpathy-guidelines" "$skills\"; Remove-Item -Recurse -Force "$env:TEMP\kp"
}
if (-not (Test-Path "$skills\design-tokens")) {
  git clone --depth 1 https://github.com/julianoczkowski/designer-skills.git "$env:TEMP\dz"
  foreach ($s in 'brief-to-tasks','design-brief','design-flow','design-review','design-tokens','information-architecture') {
    Copy-Item -Recurse -Force "$env:TEMP\dz\$s" "$skills\$s" }
  Copy-Item -Recurse -Force "$env:TEMP\dz\frontend-design" "$skills\designer-frontend-design"
  Copy-Item -Recurse -Force "$env:TEMP\dz\grill-me" "$skills\designer-grill-me"
  Remove-Item -Recurse -Force "$env:TEMP\dz"
  Write-Host "NOTE: edit name: in designer-frontend-design/SKILL.md and designer-grill-me/SKILL.md to match folder" -ForegroundColor Yellow
}

Write-Host "== MCP (local) ==" -ForegroundColor Cyan
claude mcp add --scope user magic -- npx -y "@21st-dev/magic@latest"
claude mcp add --scope user nanobanana -- npx -y "@aeven/nanobanana-mcp@latest"

Write-Host "`nDone. Restart Claude Code. See SKILLS.md / MCP.md / MEMORY.md for the rest (open-design app, claude.ai connectors, graphify Stop hook)." -ForegroundColor Green
