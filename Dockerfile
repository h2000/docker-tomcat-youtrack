FROM dockerfile/ubuntu

RUN apt-get update && apt-get install -y unzip && rm -rf /var/lib/apt/lists/*

ENV JAVA_VERSION 8u40~b22
ENV JAVA_DEBIAN_VERSION 8u40~b22-2

# see https://bugs.debian.org/775775
# and https://github.com/docker-library/java/issues/19#issuecomment-70546872
ENV CA_CERTIFICATES_JAVA_VERSION 20140324

RUN apt-get update \
&& apt-get install -y \
  openjdk-8-jre-headless="$JAVA_DEBIAN_VERSION" \
  ca-certificates-java="$CA_CERTIFICATES_JAVA_VERSION" \
&& rm -rf /var/lib/apt/lists/*

# see CA_CERTIFICATES_JAVA_VERSION notes above
RUN /var/lib/dpkg/info/ca-certificates-java.postinst configure

# install youtrack
ENV YOUTRACK_BUILD 6.0.12619

RUN mkdir -p /youtrack/dist
WORKDIR /youtrack/dist
ADD https://download.jetbrains.com/charisma/youtrack-${YOUTRACK_BUILD}.jar /youtrack/dist
RUN chmod +r youtrack-${YOUTRACK_BUILD}.jar && \
    ln -s youtrack-${YOUTRACK_BUILD}.jar youtrack.jar
    
RUN mkdir /youtrack/home
RUN groupadd -r youtrack
RUN useradd -r -g youtrack -d /youtrack/home youtrack
RUN chown -R youtrack:youtrack /youtrack/home

USER youtrack
    
# youtrack
ADD log4j.xml /etc/youtrack/log4j.xml 
VOLUME /var/lib/youtrack
EXPOSE 8080

CMD ["/bin/bash", "-e", "/tomcat/run.sh"]
