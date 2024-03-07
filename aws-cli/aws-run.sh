aws ec2 run-instances \
--image-id ami-0e83be366243f524a \
--count 1 \
--instance-type t2.xlarge \
--key-name stevelernercxuseast2 \
--security-group-ids sg-0b255a03981b65b40 \
--subnet-id subnet-0517e5c4de64acc2b \
--associate-public-ip-address \
--block-device-mappings 'DeviceName=/dev/sda1,Ebs={VolumeSize=50}' \
--tag-specifications \
'ResourceType=instance, Tags=[{Key=user,Value=steve.lerner},{Key=Name,Value=slerner-2xl-32GB}]' 'ResourceType=volume, Tags=[{Key=Name,Value=YourVolumeName}]'`
