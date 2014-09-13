FROM dockerfile/ubuntu

# install oracle java incl. wget, pwgen, ca-certificates
RUN \
  echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -yq --no-install-recommends wget pwgen ca-certificates && \
  apt-get install -y oracle-java7-installer && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# install tomcat
ENV TOMCAT_MAJOR_VERSION 7
ENV TOMCAT_MINOR_VERSION 7.0.55
ENV CATALINA_HOME /tomcat

RUN \
	wget -q https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz && \
    wget -qO- https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz.md5 | md5sum -c - && \
    tar zxf apache-tomcat-*.tar.gz && \
    rm apache-tomcat-*.tar.gz && \
    mv apache-tomcat* /tomcat 
RUN rm -rf /tomcat/webapps/*


# install youtrack
ENV YOUTRACK_VERSION 5.2.5-8823

RUN \ 
 mkdir -p /var/lib/youtrack && \
 wget -nv  http://download.jetbrains.com/charisma/youtrack-${YOUTRACK_VERSION}.war -O /tomcat/webapps/youtrack.war && \
 rm -rf /tmp/* /var/tmp/*

# tomcat
ADD run.sh /tomcat/run.sh
ADD setenv.sh /tomcat/bin/setenv.sh
RUN chmod +x /tomcat/*.sh && chmod +x /tomcat/bin/setenv.sh

# youtrack
ADD log4j.xml /etc/youtrack/log4j.xml 
VOLUME /var/lib/youtrack
EXPOSE 8080

CMD ["/bin/bash", "-e", "/tomcat/run.sh"]
