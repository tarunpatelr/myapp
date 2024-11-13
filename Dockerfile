FROM openjdk:21

MAINTAINER tarunpatelr@gmail.com
LABEL authors="tarun"

RUN mkdir -p /work/tomcat/

WORKDIR /work/tomcat
RUN curl -O https://dlcdn.apache.org/tomcat/tomcat-11/v11.0.1/bin/apache-tomcat-11.0.1.tar.gz
RUN tar xvfz apache*.tar.gz
RUN java -version

WORKDIR /work/tomcat/apache-tomcat-11.0.1/webapps
RUN curl -O -L https://github.com/tarunpatelr/myapp/blob/main/deploy/myapp.war

RUN useradd -ms /bin/bash myuser
RUN chown -R 777 /work/tomcat

EXPOSE 8080

USER myuser
CMD ["/work/tomcat/apache-tomcat-11.0.1/bin/catalina.sh", "run"]