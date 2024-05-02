aws ec2 run-instances \
--image-id ami-0cf2b4e024cdb6960 \
--count 1 \
--instance-type t2.xlarge \
--key-name slerner-us-west-2 \
--security-group-ids sg-032d218698f31d86f \
--subnet-id subnet-037378fd5035994fd \
--associate-public-ip-address \
--block-device-mappings 'DeviceName=/dev/sda1,Ebs={VolumeSize=48}' \
--tag-specifications \
'ResourceType=instance, Tags=[{Key=user,Value=steve.lerner},{Key=Name,Value=slerner-2xl}]' 'ResourceType=volume, Tags=[{Key=Name,Value=YourVolumeName}]'