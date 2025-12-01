# Docker Cheat Sheet

## Installation
**Install Docker on Ubuntu:**
```bash
bash <(curl -s https://raw.githubusercontent.com/stevelerner/devops-technique/master/docker-install.sh)
```

## Container Management
**Create an ubuntu docker container:**  
`docker pull ubuntu`

**See running docker containers:**  
`docker ps` 

**Run and name a container in background:**  
`docker run -idt --name CONTAINERNAME CONTAINERIMAGENAME bash`

**Run container in background with network using hosts's network:**  
`docker run -idt --network host --name CONTAINERNAME CONTAINERIMAGENAME bash`

**Enter container as root in bash shell:**  
`docker exec -it CONTAINERNAME bash`

## Image Management
**Build image from dockerfile with name:**  
`docker build . -f DOCKERFILE -t NAME `

**Build image from specific file:**  
`docker build -t CONTAINERIMAGENAME - < DOCKERBUILDFILE`

**Check images:**  
`docker images`

**Tag image:**  
`docker tag IMAGEID YOURDOCKERHUBUSERNAME/YOURREPOSITORYID:TAG`

## Docker Hub
**Log in to dockerhub:**  
`docker login`

**Push image to dockerhub:**  
`docker push YOURDOCKERHUBUSERNAME/YOURREPOSITORYID`
