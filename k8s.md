# Kubernetes (K8s) Cheat Sheet

**Reference:** [kubectl Cheat Sheet](https://opensource.com/article/20/5/kubectl-cheat-sheet)

## Installation
**Install k3s:** [k3s.io](https://k3s.io/)
```bash
curl -sfL https://get.k3s.io | sh -
sudo chmod 644 /etc/rancher/k3s/k3s.yaml
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
```

**Install K3s on Ubuntu:**  
```bash
bash <(curl -s https://raw.githubusercontent.com/stevelerner/devops-technique/master/k3s.sh)
```

**Install k9s:** [Releases](https://github.com/derailed/k9s/releases)

## Configuration & Context
**Colima (current Mac setup, see [colima-docker.md](colima-docker.md)):**  
`kubectl config use-context colima`

**Docker Desktop for Mac:**  
`kubectl config use-context docker-desktop`

**Change default namespace:**  
`kubectl config set-context --current --namespace=<insert-namespace-name-here>`    

**Validate context:**  
`kubectl config view --minify | grep namespace:`

## Pod Management
**Show all pods:**  
`kubectl get pods --all-namespaces`

**Shell into pod:**  
`kubectl exec --stdin --tty PODNAME -- /bin/bash`

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
`kubectl apply -f [.yaml file] --force`

**View config of resource:**  
`kubectl get RESOURCETYPE RESOURCENAME --output yaml`  
Example: `kubectl get pod PODNAME --output yaml | more`

**Patch resource:**  
`kubectl patch RESOURCETYPE DEPLOYMENTNAME --patch "$(cat UPDATEDFILE.yaml)"`  
Example: `kubectl patch deployment DEPLOYMENTNAME --patch "$(cat patch-file.yaml)"`

## Ingress
**Show ingress controllers:** `kubectl get ing -A`   
**Delete ingress controllers:** `delete ingress INGRESSNAME`  

## Debugging Container
**Install ping/curl on minimal container:**  
`apt-get -y update`  
`apt install -y curl`  
`apt install -y iputils-ping`  

**Minimal container for testing:** see [`ubuntu.yaml`](ubuntu.yaml) in the repo root — spins up an `ubuntu:latest` pod that just sleeps forever, ready for `kubectl exec` debugging.
```bash
kubectl apply -f ubuntu.yaml
```
