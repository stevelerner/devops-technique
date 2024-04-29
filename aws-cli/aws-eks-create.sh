eksctl create cluster \
--name sl-cluster \
--region us-east-2 \
# check eks k8s version below
--version 1.29 \
--node-type t3.xlarge \
--nodes 1