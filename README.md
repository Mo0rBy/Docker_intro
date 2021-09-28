# Docker
## What is Docker?
Docker is an open source containerization platform. It enables developers to package applications into containers—standardized executable components combining application source code with the operating system (OS) libraries and dependencies required to run that code in any environment.

### Docker over VirtualBox
Docker uses virtual machines (VMs) within its containers. This means that it can be used to run VMs that you need in order to develop, build or test things on your local machine. Docker works by sharing resources between your localhost and its VM's in a much more efficient way than VirtualBox. Therefore, Docker is more lightweight and much faster than using VirtualBox or Vagrant to set up VMs.

![](https://github.com/Mo0rBy/Docker_intro/blob/main/img/Demystifying-containers_image1.png)

## What are microservices?
Microservices are a cloud native archtectural approach in which a single application is composed of many loosely coupled and independently deployable smaller components, or services. The advantages of a microservices archtecture are:
- Code can be updated more easily.
- Different teams can use different tools, technologies or programming languages for different components of the system.
- Individual components can be scaled independently of one another, reducing the amount of time and resources that are wasted in scaling up an entire application because a single feature is experiencing too much load.

The most important benefit that a microservices architecture provides is that it allows organisations and groups of teams to operate in a manner that is __*more agile*__.

## Microservices vs Monolithic
### Monolithic architecture
We have previously created a web app and database using monolithic architecure. The advantages of using monolithic architecture are:
- **Simple and easy** - in all aspects.
    - Creation and building
    - Testing
    - Deployment

However, the disadvantages of monolithic architecure:
- Large (possible complicated) code base
- Size of the application can significantly affect startup time
- Each element is dependent on another - difficult to change/update things post-deployment

### Microservices architecture
The advantages of independent components, increased scalability and agile workflow that come with a microservices architecture have already been highlighted. The disadavantages of such architecture are:

- Extra complexity - The architecture is a distributed system of containers that must be able to communicate with each other.
- Testing - Much harder to test many independent deployable components.
- Cost - For microservices architecure, sufficient hosting infrastructure is required, with skilled teams that have the skills to understand and manage the services.

![](./img/Frame-1.webp)


--------------------------------------------------------------------------------------

#### Docker Commands
- `docker pull <name-of-image>`
- `docker run <name-of-image>` - *Docker run will `pull` then `run` the referenced image if `docker pull` was not executed*
- `docker build -t mo0rby/sre_moorby:v1` - Creates an image with the given name
- `docker push <name-of-image>`
- `docker ps` or `docker ps -a`- Lists container ID's and their images
- `docker stop <container-id>` - Stops a container
- `docker start <container-id>` - Starts a container
- `docker rmi <name-of-image>` > `-f` to force - Removes the container __AND__ image
- `docker rm <container-id>` > `-f` to force - Removes __ONLY__ the container (image is kept)
- `docker exec -it <container-id> sh` - Shell into the container
    - If this doesn't work > `alias docker="winpty docker"`, then try again.
- `docker commit <container-id>` - Save any changes made in the container (creates a new image) *[Best practice to include a version number tag]*
- `docker logs <container-id>` - Shows logs for the given container-ID
- `docker cp <host-relative-path-of-file> [container-ID]:/<target-absolute-path-for-file>` - Copies a file from the localhost into the given container

## Naming convention for Docker images
Images must start with your account ID, followed by the name of the image. It is best practice to define a version number.

E.G. >> "mo0rby/image-name:v1.1"

## Lifecycle of a container
Stop >> Start >> Remove

Stopped state - Still holds the data on the container
Removed state - Completely deletes the container with all the data

## Interact with a running container


## Moving onto Nginx
`docker run -d -p 80:80 nginx` > Downloads nginx image and runs it in a container
`docker exec -it <container-id>` > SSH into the machine
`cd /usr/share/nginx/html` > Default location of `index.html` (nginx welcome page)

## Creating an image from a Dockerfile
### Creating a Dockerfile
We can create our own image using a "Dockerfile". This particular Dockerfile creates our own image from the remote "nginx" image, copys the `index.html` file from our localhost onto the Docker container, exposes port 80, and runs nginx (the syntax of the `CMD` command is very important).

```Docker
# BUILDING OUR OWN IMAGE

# Choose the image
FROM nginx

LABEL MAINTAINER=johnsmith@gmail.com
# Adds a label telling people who the author/maintainer is

# Copy index.html from localhost to container
COPY index.html /usr/share/nginx/html/index.html 

# Portmap the container (port 80)
EXPOSE 80

# CMD to launch the Nginx web server
CMD ["nginx", "-g", "daemon off;"]
```
### Creating and running the image from the Dockerfile
To execute the Dockerfile, we run `docker build -t [accID]/[repo-name] <Dockerfile-path>`. This creates an image according to the Dockerfile and gives it the allocated name. We can then run a container with the image by executing `docker run -d -p 80:80 [accID]/[repo-name]:[TAG]`

After *building* the image, it is possible to push the image to a repo.

## Creating a Micro-service for the Node-app with Docker
- Build an image for the app
- Select the correct image for node `node`
- `LABEL`
- `COPY` the dependencies from localhost to container (app folder)
- Copy pack.json files
- `RUN npm install`
- `RUN npm install express` (in some cases)
- `RUN seeds/seed.js` (when we have the DB)
- `EXPOSE 3000`
- `CMD ["node", "app.js"]`