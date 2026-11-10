# Debugging Cheat Sheet (macOS)

## Network
```bash
lsof -nP -iTCP:5005 -sTCP:LISTEN     # what is listening on a port (and which process)
nc -vz HOST PORT                     # is a port reachable
curl -v http://HOST:PORT/path        # full request/response, TLS handshake
curl -sS -o /dev/null -w '%{http_code} %{time_total}s\n' URL
dig +short example.com               # DNS
scutil --dns | head -30              # which resolvers macOS is using
sudo tcpdump -i any -nn port 4318    # raw packets (or open in Wireshark)
brew install mitmproxy && mitmproxy  # inspect/replay HTTP(S) from an app
```

## Processes and disk
```bash
ps aux | grep -i NAME
kill -9 PID
df -h / ; du -sh * | sort -h | tail
```

## Containers (Colima)
```bash
colima list; docker context show     # right VM?
docker logs -f NAME; docker stats --no-stream
colima ssh -p PROFILE -- <cmd>       # run a command inside the VM (e.g. ss -ltnp)
```
