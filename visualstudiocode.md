configure multipass on mac for Code access:  
```
rm -rf ~/.ssh/known_hosts 
rm -rf ~/.ssh/id_rsa 
sudo cp /var/root/Library/Application\ Support/multipassd/ssh-keys/id_rsa ~/.ssh/
sudo chmod 744 /Users/sl/.ssh/id_rsa
ssh ubuntu@10.211.55.2
```
