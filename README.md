Nginx is a simple webserver with php support. The config files reside in /config for easy user customization.

nginx

Supported Architectures
Our images support multiple architectures such as x86-64, arm64 and armhf. We utilise the docker manifest for multi-platform awareness. More information is available from docker here and our announcement here.

Simply pulling linuxserver/nginx should retrieve the correct image for your arch, but you can also pull specific arch images via tags.

The architectures supported by this image are:

Architecture	Tag
x86-64	amd64-latest
arm64	arm64v8-latest
armhf	arm32v7-latest
Usage
Here are some example snippets to help you get started creating a container.

docker
docker create \
  --name=nginx \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/London \
  -p 80:80 \
  -p 443:443 \
  -v </path/to/appdata/config>:/config \
  --restart unless-stopped \
  linuxserver/nginx
docker-compose
Compatible with docker-compose v2 schemas.

---
version: "2"
services:
  nginx:
    image: linuxserver/nginx
    container_name: nginx
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/London
    volumes:
      - </path/to/appdata/config>:/config
    ports:
      - 80:80
      - 443:443
    restart: unless-stopped
Parameters
Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate <external>:<internal> respectively. For example, -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080 outside the container.

Parameter	Function
-p 80	http
-p 443	https
-e PUID=1000	for UserID - see below for explanation
-e PGID=1000	for GroupID - see below for explanation
-e TZ=Europe/London	Specify a timezone to use EG Europe/London
-v /config	Contains your www content and all relevant configuration files.
Environment variables from files (Docker secrets)
You can set any environment variable from a file by using a special prepend FILE__.

As an example:

-e FILE__PASSWORD=/run/secrets/mysecretpassword
Will set the environment variable PASSWORD based on the contents of the /run/secrets/mysecretpassword file.

User / Group Identifiers
When using volumes (-v flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user PUID and group PGID.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance PUID=1000 and PGID=1000, to find yours use id user as below:

  $ id username
    uid=1000(dockeruser) gid=1000(dockergroup) groups=1000(dockergroup)


Application Setup
Add your web files to /config/www for hosting.
Modify the nginx, php and site config files under /config as needed
Protip: This container is best combined with a sql server, e.g. mariadb

Support Info
Shell access whilst the container is running: docker exec -it nginx /bin/bash
To monitor the logs of the container in realtime: docker logs -f nginx
container version number
docker inspect -f '{{ index .Config.Labels "build_version" }}' nginx
image version number
docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/nginx
Updating Info
Most of our images are static, versioned, and require an image update and container recreation to update the app inside. With some exceptions (ie. nextcloud, plex), we do not recommend or support updating apps inside the container. Please consult the Application Setup section above to see if it is recommended for the image.
