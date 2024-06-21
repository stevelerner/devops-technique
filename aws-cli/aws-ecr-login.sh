aws ecr-public get-login-password --region us-east-1 | sudo docker login --username AWS --password-stdin public.ecr.aws
aws ecr get-login-password --region us-east-1 | sudo docker login --username AWS --password-stdin 104013952213.dkr.ecr.us-east-1.amazonaws.com
