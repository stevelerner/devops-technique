# AI Coding Agents (Claude Code and friends)

## Setup
```bash
npm i -g @anthropic-ai/claude-code    # or the installer from claude.com/claude-code
cd your-repo && claude                # start in a project; /init writes a first CLAUDE.md
claude -p "explain this repo"         # one-shot, non-interactive (scripts, CI)
claude --continue                     # resume the last session in this folder; --resume to pick one
```
Useful in-session commands: `/init`, `/compact` (summarise to free context), `/clear`, `/resume`, `/mcp`, `/permissions`.

## Instructions the agent reads
| File | Scope |
|---|---|
| `~/.claude/CLAUDE.md` | every project (your global preferences: reply style, commit rules) |
| `CLAUDE.md` in the repo | that project (how to build/test/run, conventions, gotchas) |
| `AGENTS.md` | the cross-tool equivalent (Zed, Codex and others read it); keep one canonical file and point the other at it |
Put things the agent cannot discover from the code: the command that actually runs the tests, which Docker context to use, ports, "do not touch X". Keep it short; stale instructions are worse than none.

## Parallel agents with worktrees
Two agents in one folder edit each other's files. Give each its own worktree and branch:
```bash
git worktree add ../repo-auth -b feat/auth
git worktree add ../repo-docs -b docs/refresh
(cd ../repo-auth && claude)      # one terminal per agent
```
Merge via PRs, then `git worktree remove ../repo-auth`. See [git.md](git.md).

## MCP (tools and data sources for the agent)
```bash
claude mcp add NAME -- npx -y SOME-MCP-SERVER           # local stdio server
claude mcp add --transport http NAME https://host/mcp   # remote server
claude mcp list
```
Scopes: user (all projects), project (`.mcp.json`, shared in git), local (just you in this repo). Only add servers you trust: they run with your permissions.

## Habits that work
- **Tests first:** give the agent a command that proves it worked (`pytest`, a script that hits the API). Self-checks beat reading diffs.
- **Small PRs from agents:** one task per branch/worktree; review the diff, not the transcript.
- **Hooks and skills:** automate "always do X after Y" (format on save, run tests before commit) with hooks in `settings.json`; package repeatable workflows as skills. A rule in CLAUDE.md is a request; a hook is enforced.
- **Long sessions:** `/compact` early, or start fresh with a short handoff file (what is done, what is next, gotchas). Memory files (`~/.claude/projects/.../memory`) persist facts across sessions.
- **Local models:** Ollama in Zed's agent panel works for editing; large context needs a matching `num_ctx` (see [zed.md](zed.md)).
- **Commit and push only when you ask**: say so in CLAUDE.md so it is the default.
