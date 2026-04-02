# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Project Does

A Microsoft Graph API tool that creates OneNote pages with embedded file attachments. The user provides an access token from [Microsoft Graph Explorer](https://developer.microsoft.com/en-us/graph/graph-explorer) and the tool posts a new page to a specified OneNote section.

## Running the Script

**Prerequisites:**
```bash
pip install requests requests-toolbelt
# Also requires tcl/tk for the GUI launcher
```

**Three entry points:**

```bash
# Direct Python invocation
python script.py <access_token>

# Via bash wrapper
bash script.sh <access_token>

# Via Tcl/Tk GUI (secure token input)
wish token.tcl
```

No build step, no test suite, no linter configured.

## Required Manual Configuration

Before running, edit `script.py` and set `section_id` (line 14) to your actual OneNote section ID. Retrieve it from the Graph API:

```bash
curl -H "Authorization: Bearer <token>" \
  'https://graph.microsoft.com/v1.0/me/onenote/sections' | jq '.value[] | {id, displayName}'
```

See `API-EXAMPLES.md` for more Graph API query examples.

## Architecture

Three-layer pipeline:

1. **`token.tcl`** — Tcl/Tk GUI for secure token entry; calls `script.sh` with the token
2. **`script.sh`** — Thin bash wrapper that passes arguments to `script.py`
3. **`script.py`** — Core logic: builds OneNote HTML, encodes a multipart body with file attachments from `assets/`, and POSTs to `https://graph.microsoft.com/v1.0/me/onenote/sections/<id>/pages`

The `assets/` directory (not in repo) must contain the files referenced in `script.py`'s HTML template (`example.pdf`, `r4inbow_show3r.png`).
