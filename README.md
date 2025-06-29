# Docker

This repository contains Docker-related examples and projects.

## Contents

- Sample Dockerfiles
- Basic Docker Compose files
- Example node application with Docker
- Useful Docker commands and tips

## Usage

### Build a Docker image

```bash
sudo docker run -d -p 3000:3000 basic-docker-setup .
# Docker


# Docker

1. Check docker version

```bash
$ docker -v
```

1. check docker containers running

```bash
$ docker ps
$ docker container ls
```

3 . check all docker container (whether running or not)

```bash
$ docker container ls -a
//-a --> all
```

1. to remove a docker container

```bash
$ docker rm <container_name>
```

1. to check list of all docker images

```bash
$ docker images
```

5.B   to remove docker image 

```bash
$ docker rm <image-name>
$ docker rmi
```

6.A to create a new docker container and make it run and also execute a command

```bash
$ docker run image_name -it

$ docker run --name container_name -it image_name

//-it --> interactive --> when the container is spinned up, stay inside it
//using -it is essential else container will exist whenever tried to start

$ docker run -it ubuntu
$ docker run --name my-node-container -it node
```

6.B To pull image manually

```bash
$ docker pull <image-name>
$ docker pull mongo
```

1. to start  an existing container

```bash
$ docker start container_name
```

1. to stop an running container

```bash
$ docker stop container_name
$ docker kill container_name/id
```

1. to execute a command in container
    1. ***container should be up and running***
    2. if command is just to be executed and then not staying inside container
    
    ```bash
    $ docker exec container_name command_name
    $ docker exec my-ubuntu ls
    ```
    
    c. if command is to be executed and staying inside the container
    
    ```bash
    $ docker exec -it container_name command_name
    $ docker exec -it my-ubuntu bash
    ```
    
2. to  get out of container command, while keeping the container running

```bash
ctrl + d
```

1. to expose the container to local machine - 
    1. **PORT MAPPING**
    
    ```bash
    $ docker run --name conatainer-name -it -p <local-port>:<container-port> image-namge
    
    $ docker run --name node-container -d -p 3000:3000 node-express-server
    
    -d (detach mode -> for running in background)
    ```
    
    b. Updating Ports of existing container
    
    ```bash
    $ docker container update --publish-add <host_port>:<container_port> container_name_or_id
    
    ```
    
    c. **ENVIRONMENTAL VARIABLES**
    
    ```bash
    $ docker run --name conatainer-name -it -e key=value -e key=value image-namge
    $ docker run --name firebase-container -it -e databaseURL="abc.firebasedatabase.app" firebase
    ```
    

```bash
$ docker run --name my-postgres -d -p 5432:5432 -e POSTGRES_PASSWORD=mysecretpassword postgres
```

1. Building a Custom Images
    
    let say, to create a image of node-server running on ubuntu
    
    1. create a node project using
    
    ```bash
    $ mkdir my-node-project
    $ cd my-node-project
    $ npm init -y
    ```
    
    1. write index.js file
    2. create a file `dockerFile`  with exact name without any extension in same folder
    3. enter scripts
    
    ```bash
    FROM ubuntu
    
    RUN apt-get update
    RUN apt-get install -y curl
    RUN curl -sL https://deb.nodesource.com/setup_18.x | bash -
    RUN apt-get upgrade -y
    RUN apt-get install -y nodejs
    
    COPY package.json package.json
    COPY package-lock.json package-lock.json
    COPY main.js index.js
    
    RUN npm install
    
    ENTRYPOINT [ "node", "main.js" ]
    ```
    
    1. build the image locally
    
    ```bash
    $ dockert build -t new-image-name path
    // t --> tag
    // path --> . for same folder
    // path --> ./folder-containing-dockerFile
    ```
    
    ```bash
    $ docker build -t my-node-server .
    ```
    

1. Pushing a custom Image to https://hub.docker.com
    1. create a image repo with name my-custom-image using my-account on [hub.docker.com](http://hub.docker.com/)
    2. copy the link on image repo - “my-account/my-custom-image”
    3. build this remote image locally
    
    ```bash
    $ docker build -t my-account/new-image
    ```
    
    this will create an empty image locally with name “my-account/my-custom-image”
    
    d. to push your local image to this remote image, first login
    
    ```bash
    $ docker login
    //enter credentials
    
    $ docker push my-account/my-custom-image
    ```
    
2. Docker Compose - *Running multiple containers using Script*
    1. create file `Docker-compose.yml`
    2. copy the code below in this file
    
    ```bash
    version: "3.8"
    
    services: 
      postgres:
        image: postgres # hub.docker.com
        ports:
          - "5432:5432"
        environment:
          POSTGRES_USER: postgres
          POSTGRES_DB: review
          POSTGRES_PASSWORD: password
    
      redis:
        image: redis
        ports:
          - "6379:6379"
    ```
    
    c. for Running all services
    
    ```bash
    $ docker compose up
    
    $ docker compose up -d
    //-d --> to run in background so that terminal can be used
    ```
    
    e. stop and remove all services
    
    ```bash
    $ docker compose download
    ```
