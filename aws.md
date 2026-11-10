# AWS CLI Cheat Sheet

Configure once with `aws configure` (or `aws configure sso`). Use `AWS_PROFILE` / `--region` rather than hardcoding accounts in scripts.

## EC2
**List instances (table):**
```bash
aws ec2 describe-instances \
  --query "Reservations[*].Instances[*].{Name:Tags[?Key=='Name']|[0].Value,InstanceId:InstanceId,State:State.Name,Type:InstanceType,PublicIP:PublicIpAddress}" \
  --output table
```

**Start / stop / terminate:**
```bash
aws ec2 start-instances     --instance-ids i-0123456789abcdef0
aws ec2 stop-instances      --instance-ids i-0123456789abcdef0
aws ec2 terminate-instances --instance-ids i-0123456789abcdef0
```

**Launch from a launch template (keeps AMI/key/subnet out of scripts):**
```bash
aws ec2 run-instances --launch-template LaunchTemplateId=lt-xxxxxxxx --count 1
```

## ECR
```bash
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com
aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws
```

## EKS
```bash
brew install eksctl            # or see https://eksctl.io
eksctl create cluster --name NAME --region us-west-2 --nodes 1 --node-type t3.xlarge
aws eks update-kubeconfig --region us-west-2 --name NAME
eksctl delete cluster --name NAME --region us-west-2      # stop paying for it
```
Prefer a `cluster.yaml` (`eksctl create cluster -f cluster.yaml`) for anything you will recreate. Use current instance families (`t3`/`m6i`/`m7g`), not `t2`.
