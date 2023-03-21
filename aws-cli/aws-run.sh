aws ec2 run-instances \
    --image-id ami-0557a15b87f6559cf \
    --instance-type t3.large \
    --security-group-ids sg-03dd9bca624edbbb8 \
    --key-name infraarc-demo