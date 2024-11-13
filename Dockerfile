FROM openjdk:21

MAINTAINER tarunpatelr@gmail.com
LABEL authors="tarun"

RUN mkdir /opt/tomcat/

WORKDIR /opt/tomcat
RUN curl -O https://dlcdn.apache.org/tomcat/tomcat-11/v11.0.1/bin/apache-tomcat-11.0.1.tar.gz
RUN tar xvfz apache*.tar.gz
RUN mv apache-tomcat-11.0.1/* /opt/tomcat/.
RUN java -version

WORKDIR /opt/tomcat/webapps
RUN curl -O -L https://github.com/tarunpatelr/myapp/blob/main/deploy/myapp.war

EXPOSE 8080

CMD ["/opt/tomcat/bin/catalina.sh", "run"]