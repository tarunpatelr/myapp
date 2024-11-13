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

RUN useradd -ms /bin/bash tomcat-user
RUN chown -R tomcat-user /opt/tomcat/apache-tomcat-11.0.1
USER tomcat-user

EXPOSE 8080

CMD ["/opt/tomcat/apache-tomcat-11.0.1/bin/catalina.sh", "run"]