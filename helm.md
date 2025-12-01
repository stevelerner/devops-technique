# Helm Cheat Sheet

## Installation
**Install helm on ubuntu:**
```bash
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
```

## Commands

### Install
```bash
helm install --set key1=value1 \
--set key2=value2 [release] [chart i.e. chart/release]
```

### Upgrade
**Find repo:** `helm list`  
**Find the chart/release:** `helm search repo [reponame]`  
**Find running release:** `helm list`  

**To upgrade:**  
`helm upgrade [runnning release] [chart/release]`

**With new keys:**  
```bash
helm install [release] [chart i.e. chart/release] \
--set key1=value1 \
--set key2=value2
```

**Helm values update from file:**
```bash
helm upgrade --reuse-values -f ./file.yaml [release] [chart/release]
```
