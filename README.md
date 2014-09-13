docker-tomcat-youtrack
======================

Docker with tomcat and youtrack

build with:

	$ docker build -t h2000/docker-tomcat-youtrack .

run with:
	
	$ docker run -t -i -p 8888:8080 -v ~/playspace/youtrack/var-lib-youtrack:/var/lib/youtrack h2000/docker-tomcat-youtrack
