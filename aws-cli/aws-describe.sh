aws ec2 describe-instances \
--query "Reservations[*].Instances[*].{PublicDnsName:PublicDnsName,PublicIP:PublicIpAddress,Type:InstanceType,Name:Tags[?Key=='Name']|[0].Value,Status:State.Name}"  \
--filters "Name=instance-state-name,Values=running"  \
--output table