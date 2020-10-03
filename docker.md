Create an ubuntu docker container  
`docker pull ubuntu`

Build image from dockerfile with name  
`docker build -t NAME .`

Build image from specific file  
`docker build -t CONTAINERIMAGENAME - < DOCKERBUILDFILE`

Run and name a container in background  
`docker run -id --name CONTAINERNAME CONTAINERIMAGENAME`

Run container with network using hosts's network  
`docker run -id --network host --name CONTAINERNAME CONTAINERIMAGENAME`

Enter container as root in bash shell  
`docker exec -it CONTAINERNAME bash`

Install sudo  
`docker exec -it  --user root ubuntu apt-get install -y sudo`

Run docker container Ubuntu as user 'nobody'  
`docker run --name ubuntu --user nobody -id ubuntu`

Get back into container as user 'nobody'
`docker exec -it --user nobody ubuntu /bin/bash`

Execute commands as root  
`docker exec -it  --user root ubuntu apt-get -y update`

Install sudo  
`docker exec -it  --user root ubuntu apt-get install -y sudo`
