FROM dockerfile/ubuntu

RUN apt-get update && apt-get install -y unzip && rm -rf /var/lib/apt/lists/*

ENV JAVA_VERSION 8u40~b22
ENV JAVA_DEBIAN_VERSION 8u40~b22-2

# see https://bugs.debian.org/775775
# and https://github.com/docker-library/java/issues/19#issuecomment-70546872
ENV CA_CERTIFICATES_JAVA_VERSION 20140324

RUN apt-get update
RUN apt-get install -y \
  openjdk-7-jre-headless \
  ca-certificates-java \
&& rm -rf /var/lib/apt/lists/*

# see CA_CERTIFICATES_JAVA_VERSION notes above
RUN /var/lib/dpkg/info/ca-certificates-java.postinst configure

# install youtrack
ENV YOUTRACK_BUILD 6.0.12619

RUN mkdir -p /youtrack/dist
WORKDIR /youtrack/dist
ADD https://download.jetbrains.com/charisma/youtrack-${YOUTRACK_BUILD}.jar /youtrack/dist/
RUN chmod +r /youtrack/dist/youtrack-${YOUTRACK_BUILD}.jar && \
    ln -s /youtrack/dist/youtrack-${YOUTRACK_BUILD}.jar /youtrack/dist/youtrack.jar
    
RUN mkdir /youtrack/home
RUN groupadd -r youtrack
RUN useradd -r -g youtrack -d /youtrack/home youtrack
RUN chown -R youtrack:youtrack /youtrack/home

USER youtrack
    
# youtrack
ADD log4j.xml /etc/youtrack/log4j.xml 
VOLUME /var/lib/youtrack
EXPOSE 8080

CMD java -Xmx1g -Ddatabase.location=/var/lib/youtrack/teamsysdata -Djetbrains.youtrack.disableBrowser=true -Djetbrains.youtrack.enableGuest=false -Djetbrains.mps.webr.log4jPath=/etc/youtrack/log4j.xml -Djava.awt.headless=true -jar /youtrack/dist/youtrack.jar 8080/youtrack
