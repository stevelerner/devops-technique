eksctl create cluster \
--name sl-cluster \
--region us-west-2 \
--version 1.29 \
--node-type t3.xlarge \
--nodes 1 \
--vpc-public-subnets=subnet-0db03b53e2a07059d,subnet-0da0eeca1553541f2