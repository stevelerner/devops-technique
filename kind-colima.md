# Local Kubernetes: kind on Colima

kind runs a Kubernetes cluster as a container inside the Colima Docker VM. No Docker Desktop, no minikube. See [colima-docker.md](colima-docker.md) for the VM.

```bash
brew install colima docker kubectl kind helm k9s
colima start --cpu 4 --memory 6 --disk 60 --vm-type vz --vz-rosetta --mount-type virtiofs
kind create cluster --name dev
kubectl config use-context kind-dev      # contexts are named kind-<cluster>
kubectl get nodes
```

## Reach the cluster from your Mac
The cluster lives inside the VM, so map host ports to NodePorts when you create it (can't be added later):
```yaml
# kind-config.yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
  - role: control-plane
    extraPortMappings:
      - { containerPort: 30005, hostPort: 5005, protocol: TCP }   # NodePort 30005 -> localhost:5005
```
```bash
kind create cluster --name dev --config kind-config.yaml
```
Then expose the service as `type: NodePort` with `nodePort: 30005`. (`LoadBalancer` services stay pending on kind.)

## Use local images (no registry)
Build with the Colima Docker, then load into the cluster:
```bash
docker build -t myapp:dev .
kind load docker-image myapp:dev --name dev
```
Use `imagePullPolicy: IfNotPresent` (or `Never`) and a non-`latest` tag, otherwise Kubernetes tries to pull from a registry.

## Housekeeping
```bash
kind get clusters
kind delete cluster --name dev
docker --context colima ps          # the kind node is just a container (use your profile's context)
```
- Only one thing can bind a host port: don't run the same ports in plain Docker and in kind at once.
- With several Colima profiles, kind uses the active Docker context. Check `docker context show` before `kind create cluster`.
- kind and Docker contexts are separate: `kubectl config get-contexts` for clusters, `docker context ls` for VMs.
- Memory: a kind node needs roughly 1 GB idle; give the VM 4-6 GB when running real workloads.
