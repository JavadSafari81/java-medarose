FROM openjdk:11-jdk-slim

#WORKDIR /app
COPY apache-tomee-webprofile-8.0.3/ .

EXPOSE 8080 8005

CMD ["java", \
    "-Djava.util.logging.config.file=./conf/logging.properties", \
    "-Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager", \
    "-javaagent:./lib/openejb-javaagent.jar", \
    "-Djava.security.egd=file:///dev/urandom", \
    "-Djdk.tls.ephemeralDHKeySize=2048", \
    "-Djava.protocol.handler.pkgs=org.apache.catalina.webresources", \
    "-Dorg.apache.catalina.security.SecurityListener.UMASK=0027", \
    "-Xms512M", \
    "-Xmx1024M", \
    "-server", \
    "-XX:+UseParallelGC", \
    "-Dignore.endorsed.dirs=", \
    "-classpath", "./bin/bootstrap.jar:./bin/tomcat-juli.jar", \
    "-Dcatalina.base=.", \
    "-Dcatalina.home=.", \
    "-Djava.io.tmpdir=./temp", \
    "org.apache.catalina.startup.Bootstrap", "start"]
