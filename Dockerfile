FROM dockerfile/ubuntu

# install oracle java incl. wget, pwgen, ca-certificates
RUN \
  echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get -y update && \
  apt-get install -yq --no-install-recommends wget pwgen ca-certificates ca-certificates-java && \
  apt-get install -y oracle-java7-installer && \
  rm -rf /usr/lib/jvm/java-7-oracle/jre/lib/security/cacerts && \
  ln -sf /etc/ssl/certs/java/cacerts /usr/lib/jvm/java-7-oracle/jre/lib/security/cacerts && \
  apt-get install --only-upgrade bash && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*


# install youtrack
ENV YOUTRACK_VERSION 5.2.5-8823

RUN \ 
 mkdir -p /var/lib/youtrack && \
 wget -nv  http://download.jetbrains.com/charisma/youtrack-${YOUTRACK_VERSION}.war -O /tomcat/webapps/youtrack.war && \
 rm -rf /tmp/* /var/tmp/*


# youtrack
ADD log4j.xml /etc/youtrack/log4j.xml 
VOLUME /var/lib/youtrack
EXPOSE 8080

CMD ["/bin/bash", "-e", "/tomcat/run.sh"]
