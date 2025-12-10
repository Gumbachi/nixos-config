# Docker

`docker build -t <TAG=gumbachi/gumbotchi> <PATH=.>` build an image with path to dir with the Dockerfile \
`docker images` list images \
`docker rmi <ID>` remove an image
`docker run --env-file .env -it <ID>` create a container and run the image
`docker stop <CONTAINER>` stop a container
`docker rm <CONTAINER>` remove a container

## Push a container
`docker login`
`docker push <NAME=gumbachi/vibrant>`
