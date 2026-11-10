# Colima (Docker on Apple Silicon)

Colima runs a lightweight Linux VM (via Lima) to provide a Docker (or containerd) runtime on macOS, without Docker Desktop.

## Installation
**Install via Homebrew (Colima + Docker CLI):**
```bash
brew install colima docker docker-compose docker-buildx docker-credential-helper
```

**Verify you're on Apple Silicon (should print `arm64`):**
```bash
uname -m
```

## Basic Usage
**Start Colima with defaults:**
```bash
colima start
```

**Start with custom resources (CPU/memory/disk) on Apple Silicon (`vz` = Apple's virtualization framework, `--vz-rosetta` = fast x86 emulation, `virtiofs` = fast mounts):**
```bash
colima start --cpu 4 --memory 8 --disk 60 --vm-type vz --vz-rosetta --mount-type virtiofs
```

**Check status:**
```bash
colima status
```

**Stop the VM:**
```bash
colima stop
```

**Delete the VM (destroys the Docker image/container storage):**
```bash
colima delete
```

Once running, the regular `docker` CLI works as normal (`docker ps`, `docker build`, `docker run`, etc.) — Colima wires up the `DOCKER_HOST` for you.

## Storing Docker Images on an External SSD
Colima's VM disk (where all Docker images/containers live) is a single disk image file. To keep it on an external SSD instead of your internal drive, point Colima's data directory at the SSD before the first `colima start`.

**1. Stop and delete any existing Colima instance (this wipes current images):**
```bash
colima stop
colima delete
```

**2. Create a directory on the external SSD:**
```bash
mkdir -p /Volumes/external/colima
```

**3. Symlink Colima's config/data directory to the external SSD:**
```bash
mv ~/.colima /Volumes/external/colima/.colima-data 2>/dev/null
ln -s /Volumes/external/colima/.colima-data ~/.colima
```

**4. Start Colima — it will now create its VM disk under the SSD-backed path:**
```bash
colima start
```

**Verify the VM disk actually lives on the external volume:**
```bash
du -sh /Volumes/external/colima/.colima-data/_lima/colima/*
```

Notes:
- If the external SSD isn't mounted at boot, `colima start` will fail since `~/.colima` is a dangling symlink — mount the drive first.
- The disk image size is set with `--disk`; its location is controlled entirely by where `~/.colima` (or `$COLIMA_HOME`) points.
- You can also set `COLIMA_HOME=/Volumes/external/colima/.colima-data` in your shell profile instead of symlinking, if you prefer not to touch `~/.colima`.

## Complete setup without Docker Desktop
Everything Docker Desktop bundles (daemon, CLI plugins, credential helper, contexts) has a standalone replacement. Uninstall Docker Desktop only after this works.

**1. Install the pieces:**
```bash
brew install colima docker docker-compose docker-buildx docker-credential-helper
```

**2. Point the CLI at the Homebrew plugins and the macOS keychain** (edit `~/.docker/config.json`, merge with what is there):
```json
{
  "cliPluginsExtraDirs": ["/opt/homebrew/lib/docker/cli-plugins"],
  "credsStore": "osxkeychain"
}
```
- `docker compose` and `docker buildx` are not found without `cliPluginsExtraDirs`.
- A leftover `"credsStore": "desktop"` makes `docker login/push/pull` fail with `error getting credentials ... docker-credential-desktop: executable file not found`. Change it to `osxkeychain` and clear the stale `auths` entries.

**3. Log in to Docker Hub (token, not password) and push/pull as usual:**
```bash
docker login            # use a Docker Hub access token: https://hub.docker.com/settings/security
docker push myorg/myimage:latest
```
The token is stored in the macOS keychain; macOS may ask once to allow access.

**4. Start the VM:**
```bash
colima start --cpu 4 --memory 6 --disk 60 --vm-type vz --vz-rosetta --mount-type virtiofs
```

## Profiles and Docker contexts
Each Colima profile is a separate VM with its own Docker context: `colima start` is context `colima`, `colima start -p work` is `colima-work`.
```bash
colima list                          # profiles and their state
docker context ls                    # contexts
docker context show                  # which one plain `docker` uses right now
docker --context colima-work ps      # target one VM explicitly
export DOCKER_CONTEXT=colima-work    # or for the whole shell/script
```
Plain `docker` goes to whichever context is active, which may not be the VM you meant (it is easy to rebuild or recreate containers in the wrong VM). In scripts, pin the context at the top:
```bash
unset DOCKER_TLS_VERIFY DOCKER_HOST DOCKER_CERT_PATH
export DOCKER_CONTEXT="${DOCKER_CONTEXT:-colima-${COLIMA_PROFILE:-default}}"
```

## Gotchas
- **Bind mounts only see mounted paths.** Colima mounts `$HOME` by default. A repo elsewhere (e.g. `/Volumes/external/...`) must be mounted or bind-mounted files appear as empty directories ("is a directory" errors):
  ```bash
  colima start --mount "$HOME:r" --mount "/Volumes/external/code:w"
  ```
  Mount changes need a VM restart. `/tmp` is not mounted either.
- **Reach the Mac from a container:** `host.docker.internal`.
- **Ports published in the VM are forwarded to the Mac** (`localhost:PORT`). Two VMs that both publish the same port will collide: only one gets the host port.
- **buildx builders are tied to a context.** A `docker-container` builder created under Docker Desktop keeps pointing at its socket and fails with `Cannot connect to the Docker daemon at unix:///Users/<you>/.docker/run/docker.sock`. Remove it (`docker buildx rm <name>`, or delete `~/.docker/buildx/instances/<name>`) and use the context's built-in builder: `docker buildx use colima` (or `colima-<profile>`). Single-platform `--load` builds work fine with it.
- **Kubernetes:** use `kind` (or `colima start --kubernetes`) instead of Docker Desktop's built-in cluster. kind runs inside the Colima Docker VM.
- **Memory:** the VM size is fixed at start; raise it with `colima stop && colima start --memory 8`.
- **Apple Silicon images:** the VM is arm64, so images are arm64 unless you pass `--platform linux/amd64` (emulated; fast with `--vz-rosetta`). See [docker.md](docker.md). Local Kubernetes on top of this: [kind-colima.md](kind-colima.md).
