<div align="center">

# DevOps Technique

**Cheat sheets and scripts for an Apple Silicon Mac workflow**

Colima · Docker · kind · Zed · AI coding agents

</div>

---

## Quick start

```bash
brew install colima docker docker-compose docker-buildx docker-credential-helper kubectl kind helm k9s
colima start --cpu 4 --memory 6 --disk 60 --vm-type vz --vz-rosetta --mount-type virtiofs
docker login                      # Docker Hub token, stored in the macOS keychain
kind create cluster --name dev    # local Kubernetes inside the Colima VM
```

Details: [Docker without Docker Desktop](colima-docker.md) · [kind on Colima](kind-colima.md)

---

## Guides

### Containers and Kubernetes

| Guide | What's in it |
|---|---|
| [colima-docker.md](colima-docker.md) | Docker on macOS without Docker Desktop: Colima, Docker Hub credentials, profiles and contexts, mounts, buildx, moving Colima storage to `/Volumes/Code` via a `~/.colima` symlink |
| [kind-colima.md](kind-colima.md) | Local Kubernetes with kind: port mapping, loading local images |
| [docker.md](docker.md) | Run, build, Compose, arm64 vs amd64 |
| [k8s.md](k8s.md) | kubectl, contexts, `kubectl debug` |
| [helm.md](helm.md) | Install, upgrade, templates, OCI charts |

### Editor and AI agents

| Guide | What's in it |
|---|---|
| [zed.md](zed.md) | Zed settings, tasks, terminal, agent panel, Ollama |
| [ai-agents.md](ai-agents.md) | Claude Code: `CLAUDE.md`/`AGENTS.md`, parallel agents with worktrees, MCP, hooks |

### Tools and platform

| Guide | What's in it |
|---|---|
| [git.md](git.md) | Git and GitHub CLI, worktrees, credentials, a different GitHub account per repo |
| [aws.md](aws.md) | EC2, ECR, EKS from the CLI |
| [debugging.md](debugging.md) | Network, process and container debugging on macOS |
| [python.md](python.md) | venv and uv |
| [macos.md](macos.md) | Disk imaging and formatting, updating Bash via Homebrew |
| [ssl.md](ssl.md), [promql-faves.md](promql-faves.md) | One-liners |

---

## Scripts and config

| File | Purpose |
|---|---|
| [sync-forks.sh](sync-forks.sh) | Sync every forked repo in a GitHub account with its upstream (`gh repo sync`) |
| [.zshrc](.zshrc) | Shell aliases (`k`, `h`, `gpush`, `dc`); copy into `~/.zshrc` |
