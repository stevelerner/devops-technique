# Zed (zed.dev) Cheat Sheet

## Install and open
```bash
brew install --cask zed
zed .                 # open the current folder (CLI: Zed menu > Install CLI if `zed` is missing)
zed path/to/file:42   # open at a line
```
Command palette: `cmd-shift-p`. Open settings: `cmd-,` (file: `~/.config/zed/settings.json`). Project-local settings: `.zed/settings.json`. Browse the defaults with the palette action `zed: open default settings`.

## Settings worth knowing
```jsonc
{
  "base_keymap": "VSCode",                  // or "JetBrains", "Sublime Text", "Atom"
  "minimap": { "show": "never" },
  "terminal": { "max_scroll_history_lines": 100000 },
  "languages": { "Markdown": { "show_edit_predictions": false } }
}
```
The file is JSONC (comments and trailing commas are fine). Keep a backup before large edits (`cp settings.json settings.json.bak`).

## Terminal
Built in: `ctrl-\`` toggles the terminal panel. It is your login shell (zsh); no extra setup.

## Tasks (run commands from the editor)
Project tasks live in `.zed/tasks.json` (global ones in `~/.config/zed/tasks.json`). Run with the palette action `task: spawn`.
```json
[
  { "label": "test",  "command": "pytest", "args": ["-q"], "cwd": "$ZED_WORKTREE_ROOT" },
  { "label": "stack up", "command": "docker compose up -d --build", "use_new_terminal": true }
]
```

## AI agent panel
- **Built-in agent:** pick a model provider in the agent panel settings (Zed hosted, Anthropic, OpenAI, Ollama, ...).
- **Local models via Ollama:**
```jsonc
"language_models": {
  "ollama": {
    "api_url": "http://HOST:11434",
    "available_models": [
      { "name": "MODEL", "display_name": "My model", "max_tokens": 131072, "supports_tools": true }
    ]
  }
}
```
Set `max_tokens` to the context you actually run the model with (see ollama's `num_ctx`); Ollama silently truncates beyond it.
- **External agents (Claude Code, Codex, Gemini CLI) inside Zed** use the Agent Client Protocol (ACP): add them under `"agent_servers"` or install from the agent registry in the panel. They keep their own config and permissions.
- **Project rules:** Zed reads rules files at the repo root (`.rules`, `AGENTS.md`, `CLAUDE.md`, among others), the same files the CLI agents read. Keep one `AGENTS.md`/`CLAUDE.md` and every tool benefits. See [ai-agents.md](ai-agents.md).
- **Permissions:** `agent.tool_permissions` controls what the agent may do without asking. `default: "allow"` is convenient on a throwaway machine; use `"confirm"` anywhere you care about the files.
