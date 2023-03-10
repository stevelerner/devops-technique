https://opensource.com/article/20/5/kubectl-cheat-sheet


Install k3s https://k3s.io/  
```
curl -sfL https://get.k3s.io | sh -
sudo chmod 644 /etc/rancher/k3s/k3s.yaml
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
```

Install Docker on Ubuntu:
```bash <(curl -s https://raw.githubusercontent.com/stevelerner/devops-technique/master/k3s.sh)
```

`kubectl get pods --all-namespaces`

Show ingress controllers: `kubectl get ing -n`   
Delete ingress controllers: `delete ingress INGRESSNAME`  

Docker Desktop for Mac  
`kubectl config use-context docker-desktop`

Shell into pod  
`kubectl exec --stdin --tty PODNAME -- /bin/bash`

Change default namespace  
`kubectl config set-context --current --namespace=<insert-namespace-name-here>`    

Validate it  
`kubectl config view --minify | grep namespace:`

Force apply a configuration (to overcome clustertype/nodeport issues  
`kubectl apply -f [.yaml file] --force`

See env variables in pod  
`kubectl exec PODNAME -- printenv`

View config of resource  
`kubectl get RESOURCETYPE RESOURCENAME --output yaml` i.e.  
kubectl get pod PODNAME--output yaml | more

Patch resource  
`kubectl patch RESOURCETYPE DEPLOYMENTNAME --patch "$(cat UPDATEDFILE.yaml)"`  
i.e. kubectl patch deployment DEPLOYMENTNAME --patch "$(cat patch-file.yaml)"

Install ping/curl on minimal container  
`apt-get -y update`  
`apt install -y curl`  
`apt install -y iputils-ping`  

Minimal container deploy.yaml for testing:
```
apiVersion: v1
kind: Pod
metadata:
  name: ubuntu
spec:
  containers:
  - name: ubuntu
    image: ubuntu:latest
    # Just spin & wait forever
    command: [ "/bin/bash", "-c", "--" ]
    args: [ "while true; do sleep 30; done;" ]
```
