# Kubernetes (K8s) Cheat Sheet

**Reference:** [kubectl cheat sheet](https://kubernetes.io/docs/reference/kubectl/quick-reference/)

## Installation (macOS)
```bash
brew install kubectl kind helm k9s kubectx stern
```
Local clusters: **kind on Colima**, see [kind-colima.md](kind-colima.md).

## Configuration & Context
**Mac (Colima + kind, see [colima-docker.md](colima-docker.md)):**  
`kubectl config use-context colima` (Colima's own k8s) or `kubectl config use-context kind-<cluster>`

**List / switch contexts:** `kubectl config get-contexts`

**Change default namespace:**  
`kubectl config set-context --current --namespace=<insert-namespace-name-here>`    

**Validate context:**  
`kubectl config view --minify | grep namespace:`

## Pod Management
**Show all pods:**  
`kubectl get pods --all-namespaces`

**Shell into pod:**  
`kubectl exec -it PODNAME -- sh`

**Logs (follow / previous crash / all pods of a label):**  
`kubectl logs -f PODNAME`  
`kubectl logs PODNAME --previous`  
`stern LABEL_OR_NAME` (multi-pod tail)

**See env variables in pod:**  
`kubectl exec PODNAME -- printenv`

## Resources & Deployment
**Create k8s namespace:** [Walkthrough](https://kubernetes.io/docs/tasks/administer-cluster/namespaces-walkthrough/)

**Use env bash env variables in `deployment.yaml`:**
`export NAMESPACE=example`
In `.yaml` use: `$NAMESPACE` 
To deploy:  
```bash
envsubst < deployment.yaml  | kubectl apply -f -
```

**Force apply a configuration:** (to overcome clustertype/nodeport issues)  
`kubectl apply -f [.yaml file] --force` (deletes and recreates; only when a plain apply is rejected)

**View config of resource:**  
`kubectl get RESOURCETYPE RESOURCENAME --output yaml`  
Example: `kubectl get pod PODNAME --output yaml | more`

**Patch resource:**  
`kubectl patch RESOURCETYPE DEPLOYMENTNAME --patch "$(cat UPDATEDFILE.yaml)"`  
Example: `kubectl patch deployment DEPLOYMENTNAME --patch "$(cat patch-file.yaml)"`

## Ingress
**Show ingress controllers:** `kubectl get ing -A`   
**Delete an ingress:** `kubectl delete ingress INGRESSNAME`  

## Debugging
**Attach a throwaway debug container to a running pod (no tools needed in the image):**
```bash
kubectl debug -it PODNAME --image=nicolaka/netshoot --target=CONTAINERNAME
```
**One-off pod with a shell and network tools:**
```bash
kubectl run tmp --rm -it --image=nicolaka/netshoot -- bash
```
**Why is it pending / crashing:** `kubectl describe pod PODNAME` (Events at the bottom), `kubectl get events --sort-by=.lastTimestamp`.
