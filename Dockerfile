FROM openjdk:21

MAINTAINER tarunpatelr@gmail.com
LABEL authors="tarun"

RUN mkdir /opt/tomcat/

WORKDIR /opt/tomcat
RUN curl -O https://dlcdn.apache.org/tomcat/tomcat-11/v11.0.1/bin/apache-tomcat-11.0.1.tar.gz
RUN tar xvfz apache*.tar.gz
RUN java -version

WORKDIR /opt/tomcat/apache-tomcat-11.0.1/webapps
RUN curl -O -L https://github.com/tarunpatelr/myapp/blob/main/deploy/myapp.war


RUN groupadd -r myuser -g 501
RUN useradd -d /home/myuser -u 501 -m -s /bin/bash -g myuser myuser
RUN chown -R myuser:myuser /opt/tomcat

EXPOSE 8080

USER myuser
CMD ["/opt/tomcat/apache-tomcat-11.0.1/bin/catalina.sh", "run"]