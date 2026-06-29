# Prerequisite CLI tools

Install these first — the skills/plugins depend on them.

| Tool | Version (mine) | Why | Install |
|------|----------------|-----|---------|
| **Node.js** | 24.x (>=18) | npm/npx skills, claude-mem, caveman, impeccable | https://nodejs.org or `winget install OpenJS.NodeJS.LTS` |
| **uv** | 0.8.x | installs graphify + browser-harness (Python tools) | `curl -LsSf https://astral.sh/uv/install.sh \| sh` (mac/linux) · `irm https://astral.sh/uv/install.ps1 \| iex` (win) |
| **bun** | 1.3.x | gstack build + claude-mem worker runtime | `npm install -g bun` |
| **git** | 2.50 | cloning skill repos | https://git-scm.com |
| **yt-dlp** | 2026.x | claude-video (`watch`) downloads | `pip install --user yt-dlp` |
| **ffmpeg** | any | claude-video frame extraction | `winget install Gyan.FFmpeg` / `brew install ffmpeg` / `apt install ffmpeg` |

## PATH notes (Windows)
After install, make sure these are on your **User PATH**:
- `%USERPROFILE%\.bun\bin`  (bun native binary — claude-mem worker needs it)
- `%USERPROFILE%\.local\bin`  (uv tool shims: graphify, browser-harness)
- `%APPDATA%\Python\Python3xx\Scripts`  (yt-dlp)

Open a **fresh terminal** after editing PATH so tools resolve.
