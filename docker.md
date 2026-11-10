# Docker Cheat Sheet

On a Mac, Docker runs in a Colima VM, not Docker Desktop: see [colima-docker.md](colima-docker.md). Docker Hub login and credentials are covered there too.

## Run and inspect
```bash
docker run --rm -it ubuntu bash              # throwaway shell
docker run -d --name web -p 8080:80 nginx    # background, published port
docker ps -a                                 # containers (add -a for stopped)
docker logs -f web                           # follow logs
docker exec -it web sh                       # shell into a running container
docker stop web && docker rm web
```

## Build
```bash
docker build -t NAME .                       # Dockerfile in the current dir (context = .)
docker build -f path/Dockerfile -t NAME .    # specific Dockerfile, same context
docker buildx build --platform linux/arm64 -t NAME --load .
```
Do not use `docker build - < Dockerfile`: it sends no build context, so `COPY` fails.

## Apple Silicon (arm64) images
- Your Mac builds `linux/arm64` by default. Cloud x86 hosts need `--platform linux/amd64` (or build on the target, or use Graviton).
- Run an x86-only image anyway: `docker run --platform linux/amd64 IMAGE`. It is emulated; enable Rosetta in Colima for speed (`--vm-type vz --vz-rosetta`).
- Check what you have: `docker image inspect IMAGE --format '{{.Os}}/{{.Architecture}}'`.

## Compose
```bash
docker compose up -d --build        # build and start
docker compose ps
docker compose logs -f SERVICE
docker compose down -v              # stop and remove volumes
```
`docker compose --build` rebuilds the service image only, not images it is `FROM` (rebuild a shared base image first).

## Images and cleanup
```bash
docker images
docker tag SOURCE ORG/REPO:TAG
docker push ORG/REPO:TAG
docker system df                    # what is using disk (inside the VM)
docker system prune -af --volumes   # remove everything unused; destructive
```
