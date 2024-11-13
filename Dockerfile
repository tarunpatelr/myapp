FROM openjdk:21

MAINTAINER tarunpatelr@gmail.com
LABEL authors="tarun"

RUN mkdir /opt/tomcat/

WORKDIR /opt/tomcat
RUN curl -O https://dlcdn.apache.org/tomcat/tomcat-11/v11.0.1/bin/apache-tomcat-11.0.1.tar.gz
RUN tar xvfz apache*.tar.gz
RUN java -version

RUN useradd -ms /bin/bash myuser

RUN mv /opt/tomcat/apache-tomcat-11.0.1 /home/myuser/
RUN chown -R myuser:myuser /home/myuser/apache-tomcat-11.0.1

USER myuser
WORKDIR /home/myuser/apache-tomcat-11.0.1/webapps
RUN curl -O -L https://github.com/tarunpatelr/myapp/blob/main/deploy/myapp.war

ENV CATALINA_HOME /home/myuser/apache-tomcat-11.0.1

CMD ["/home/myuser/apache-tomcat-11.0.1/bin/catalina.sh", "run"]