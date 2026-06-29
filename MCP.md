# MCP servers

Two kinds: **claude.ai cloud connectors** (tied to your Claude account — enable by signing in,
not reproducible from this repo) and **CLI/local servers** (reproducible with `claude mcp add`).

## claude.ai cloud connectors (account-level)
Enable these from claude.ai → Connectors (or they auto-appear when signed in). Each may need
its own OAuth ("Needs authentication"). My set:

- Google Drive, Google Calendar, Gmail  (Connected)
- Cloudflare Developer Platform, Hugging Face, Vercel  (Connected)
- Figma, Stripe, ActiveCampaign, Canva, Netlify, Cloudinary, Fireflies, Notion, Sentry  (need auth)

> These are NOT added via CLI — sign in to claude.ai and authorize each. Nothing to commit.

## CLI / local servers (reproducible)

```bash
# Magic (21st.dev UI components)
claude mcp add --scope user magic -- npx -y @21st-dev/magic@latest

# nanobanana (image gen)
claude mcp add --scope user nanobanana -- npx -y @aeven/nanobanana-mcp@latest

# open-design (after installing the desktop app — path is per-machine)
claude mcp add --scope user open-design -- node "<OpenDesignDir>/resources/app/prebundled/daemon/daemon-cli.mjs" mcp
```

- **claude-mem mcp-search** — provided automatically by the claude-mem plugin (no manual add).
- **stitch** — was configured to a local `D:\gcloud\stitch-mcp-start.cmd`; machine-specific, re-point as needed.

## Verify
```bash
claude mcp list
```
