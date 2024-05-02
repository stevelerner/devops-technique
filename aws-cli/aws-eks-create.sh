eksctl create cluster \
--name slerner \
--region us-west-2 \
--nodes 1 \
# --vpc-public-subnets=subnet-0db03b53e2a07059d,subnet-0da0eeca1553541f2 \
--dry-run
# --node-type t3.xlarge \