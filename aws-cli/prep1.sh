bash <(curl -s https://raw.githubusercontent.com/stevelerner/devops-technique/master/docker-install.sh)
sudo apt install -y unzip
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -rf awscliv2.zip
# now run aws configure