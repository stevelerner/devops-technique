eksctl create cluster \
    --name=slerner \
    --region=us-west-2 \
    --nodegroup-name slerner-k8s-ng \
    --node-type t2.2xlarge \
    --nodes 1 \
    --nodes-min 1 \
    --nodes-max 3 \
    --node-private-networking \
    --vpc-private-subnets=subnet-020974f32f148db2d,subnet-030d07a7e4a659c2a \
    --vpc-public-subnets=subnet-0db03b53e2a07059d,subnet-0da0eeca1553541f2 \
    --asg-access \
    --full-ecr-access \
    --appmesh-access \
    --alb-ingress-access \
    --set-kubeconfig-context \
    --verbose 3 \
    --enable-ssm \
    --ssh-access \
    --ssh-public-key slerner-us-west-2 \
    --enable-logging=api,audit,authenticator,controllerManager,scheduler
