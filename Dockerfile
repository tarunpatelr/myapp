FROM openjdk:21

MAINTAINER tarunpatelr@gmail.com
LABEL authors="tarun"

RUN mkdir -p /work/tomcat/

WORKDIR /work/tomcat
RUN curl -O https://dlcdn.apache.org/tomcat/tomcat-11/v11.0.1/bin/apache-tomcat-11.0.1.tar.gz
RUN tar xvfz apache*.tar.gz
RUN java -version

WORKDIR /work/tomcat/apache-tomcat-11.0.1/webapps
RUN curl -O https://raw.githubusercontent.com/tarunpatelr/myapp/refs/heads/main/deploy/myapp.war

RUN useradd -ms /bin/bash myuser
RUN chmod -R 777 /work/tomcat

WORKDIR /work/tomcat/apache-tomcat-11.0.1/conf
RUN rm tomcat-users.xml
RUN curl -O https://raw.githubusercontent.com/tarunpatelr/myapp/refs/heads/main/deploy/tomcat-users.xml
RUN export ADMIN_PWD=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 13;)
RUN export ROBOT_PWD=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 13;)
RUN echo admin pwd is $ADMIN_PWD
RUN echo robot pwd is $ROBOT_PWD
RUN sed -i 's/ADMIN_PWD_PLACEHOLDER/$ADMIN_PWD/g' tomcat-users.xml
RUN sed -i 's/ROBOT_PWD_PLACEHOLDER/$ROBOT_PWD/g' tomcat-users.xml

WORKDIR /work/tomcat/apache-tomcat-11.0.1/webapps/manager/META-INF
RUN rm context.xml
RUN curl -O https://raw.githubusercontent.com/tarunpatelr/myapp/refs/heads/main/deploy/context.xml

EXPOSE 8080

USER myuser
CMD ["/work/tomcat/apache-tomcat-11.0.1/bin/catalina.sh", "run"]