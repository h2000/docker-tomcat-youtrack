docker-tomcat-youtrack
======================

Dockerfile for youtrack to run under tomcat. Tomcat is needed to have context so that it can placed in sub location like http://youdomain.name/youtrack/, standalone youtrack.jar does not work in the case. Youtracks runs under localhost:8080/youtrack.
All youtrack data is placed under the directory mapped to /var/lib/youtrack in the container. As extra bonus dockerized youtrack is registered as ubunut service docker-youtrack and a front-end server ngnix is configured.

## run it as service

create database folder for you track

	$ mkdir -p /var/lib/youtrack

download image and run container

	$ docker run -t -i -p 8888:8080 -v /var/lib/youtrack:/var/lib/youtrack h2000/docker-tomcat-youtrack

stop it with CTRL+C

### register docker youtrack service

copy file _etc_init_/docker-youtrack.conf to /etc/init/

start the service
  	
	$ service docker-youtrack start

### nginx setup
copy _etc_nginx_sites-available/youtrack file to /etc/nginx/sites-available

change your server name

	$ service nginx reload



## build it

	$ docker build -t h2000/docker-tomcat-youtrack .
