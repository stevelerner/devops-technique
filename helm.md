Install helm on ubuntu:

```
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
```

#### helm install
```
helm install --set key1=value1 \
--set key2=value2 [release] [chart i.e. chart/release]
```

#### helm upgrade

find repo: `helm list`
find the chart/release: `helm search repo [reponame]`

to find running release: `helm list`

to upgrade: `helm upgrade [runnning release] [chart/release]`

With new keys:  
```
helm install [release] [chart i.e. chart/release] \
--set key1=value1 \
--set key2=value2
```

#### helm values update from file
```
helm upgrade --reuse-values -f ./file.yaml.yaml [release] [chart/release]
```
