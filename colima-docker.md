# Colima (Docker on Apple Silicon)

Colima runs a lightweight Linux VM (via Lima) to provide a Docker (or containerd) runtime on macOS, without Docker Desktop.

## Installation
**Install via Homebrew (Colima + Docker CLI):**
```bash
brew install colima docker docker-compose
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

**Start with custom resources (CPU/memory/disk):**
```bash
colima start --cpu 4 --memory 8 --disk 60
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
- Alternatively, pass `--mountType` / use `colima start --disk` sizing to control how large the underlying disk image grows, but the location is controlled entirely by where `~/.colima` (or `$COLIMA_HOME`) points.
- You can also set `COLIMA_HOME=/Volumes/external/colima/.colima-data` in your shell profile instead of symlinking, if you prefer not to touch `~/.colima`.
