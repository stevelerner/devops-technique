aws ec2 run-instances \
--image-id ami-09c3a3c2cf6003f6c \
--count 1 \
--instance-type t2.xlarge \
--key-name slerner-us-west-2 \
--security-group-ids sg-0ace3021c90a4594c \
--subnet-id subnet-0db03b53e2a07059d \
--associate-public-ip-address \
--block-device-mappings 'DeviceName=/dev/sda1,Ebs={VolumeSize=50}' \
--tag-specifications \
'ResourceType=instance, Tags=[{Key=user,Value=steve.lerner},{Key=Name,Value=slerner-2xl-32GB}]' 'ResourceType=volume, Tags=[{Key=Name,Value=YourVolumeName}]'
