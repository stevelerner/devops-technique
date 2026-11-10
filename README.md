# DevOps Technique

Cheat sheets and scripts for my Mac (Apple Silicon) workflow: Colima + Docker, kind, Zed, and AI coding agents.

## Guides
*   **`colima-docker.md`**: Docker on macOS without Docker Desktop: Colima, Docker Hub credentials (osxkeychain), profiles and contexts, mounts, buildx, external-SSD storage.
*   **`kind-colima.md`**: local Kubernetes with kind on Colima (port mapping, loading local images).
*   **`docker.md`**: Docker/Compose commands, building for arm64 vs amd64.
*   **`k8s.md`**: kubectl cheat sheet, `kubectl debug`, contexts.
*   **`helm.md`**: Helm commands.
*   **`zed.md`**: Zed editor: settings, tasks, terminal, agent panel and Ollama.
*   **`ai-agents.md`**: Claude Code: CLAUDE.md/AGENTS.md, worktrees for parallel agents, MCP, hooks.
*   **`git.md`**: Git and GitHub CLI, worktrees, credentials.
*   **`aws.md`**: AWS CLI: EC2, ECR, EKS.
*   **`debugging.md`**: macOS network/process debugging.
*   **`python.md`**: venv and uv.
*   **`macos.md`**: disk imaging and formatting.
*   **`ssl.md`**, **`promql-faves.md`**: one-liners.

## Scripts and config
*   **`sync-forks.sh`**: syncs every forked repo in a GitHub account with its upstream via `gh repo sync`.
*   **`.zshrc`**: shell aliases (`k`, `h`, `gpush`, `dc`); copy into `~/.zshrc`.
