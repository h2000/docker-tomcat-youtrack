 #-Duser.home=/var/lib/youtrack  \
export CATALINA_OPTS="$CATALINA_OPTS \
 -XX:MaxPermSize=256m \
 -Xmx1024m  \
 -Ddatabase.location=/var/lib/youtrack/teamsysdata \
 -Djavax.net.ssl.trustStore=/etc/ssl/certs/java/cacerts  \
 -Djavax.net.ssl.trustStorePassword=changeit  \
 -Djetbrains.youtrack.disableBrowser=true  \
 -Djetbrains.youtrack.enableGuest=false  \
 -Djetbrains.mps.webr.log4jPath=/etc/youtrack/log4j.xml  \
 -Djava.awt.headless=true \
 "
