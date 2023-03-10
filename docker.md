Install Docker on Ubuntu
```
bash <(curl -s https://raw.githubusercontent.com/stevelerner/devops-technique/master/docker-install.sh)
```

Create an ubuntu docker container  
`docker pull ubuntu`

Build image from dockerfile with name  
`docker build . -f DOCKERFILE -t NAME `

Build image from specific file  
`docker build -t CONTAINERIMAGENAME - < DOCKERBUILDFILE`

Run and name a container in background  
`docker run -idt --name CONTAINERNAME CONTAINERIMAGENAME bash`

Run container in background with network using hosts's network  
`docker run -idt --network host --name CONTAINERNAME CONTAINERIMAGENAME bash`

Enter container as root in bash shell  
`docker exec -it CONTAINERNAME bash`

Push image to dockerhub  
Log in to dockerhub  
`docker login`

Check images  
`docker images`

Tag image  
`docker tag IMAGEID YOURDOCKERHUBUSERNAME/YOURREPOSITORYID:TAG`

Push image to dockerhub  
`docker push YOURDOCKERHUBUSERNAME/YOURREPOSITORYID`
