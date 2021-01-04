helm install
```
helm install --set key1=value1 \
--set key2=value2 [release] [chart i.e. chart/release]
```

helm upgrade
```
helm install [release] [chart i.e. chart/release] \
--set key1=value1 \
--set key2=value2
```

helm values update from file
```
helm upgrade --reuse-values -f ./file.yaml.yaml [release] [chart/release]
```
