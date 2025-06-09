# Use official Jenkins LTS image
FROM jenkins/jenkins:lts

# Switch to root user to install packages
USER root

# Install dependencies and Terraform
RUN apt-get update && \
    apt-get install -y wget unzip gnupg curl software-properties-common && \
    curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" > /etc/apt/sources.list.d/hashicorp.list && \
    apt-get update && \
    apt-get install terraform -y

# Return to Jenkins user
USER jenkins

# Dockerfile For JAVA APPLICATION

FROM openjdk:11
LABEL maintainer="Naresh <naresh03@gmail.com>"
LABEL version="1.0"
LABEL description="Dockerfile example for a Java application"
WORKDIR /app
COPY sample.jar /app/sample.jar
RUN echo "Building the Java application..."
EXPOSE 8080
ENTRYPOINT ["java", "-jar"]
CMD ["sample.jar"]


--------------------------------------------------------
# Dockerfile For Nodejs APPLICATION

FROM node:latest
LABEL maintainer="Naresh <naresh03@gmail.com>"
RUN echo " Try to build my application"
WORKDIR /app
COPY node-js-sample/package.json /app
EXPOSE 3000
ENTRYPOINT ["npm","start"]

---------------------------------------------------------
# Dockerfile For Python APPLICATION

FROM python:3.11.1
LABEL maintainer="Naresh <naresh03@gmail.com>"
WORKDIR /code
COPY ./requirements.txt /code/requirements.txt
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt
COPY ./main.py /code/main.py
COPY ./form.html /code/form.html
CMD ["uvicorn","main:app","--host","0.0.0.0","--port","80"]

--------------------------------------------------------------------
#CMD& Entrypoint

CMD: Defines the default command to run when the container starts
"/bin/bash": Invokes the Bash shell.
"-c": Instructs Bash to read commands from the following string.

cmd -- shell,exec(json) 

#shell
FROM ubuntu
RUN apt-get update -y
RUN apt-get install nginx -y
CMD service nginx start && bash

#exec-Json format

FROM ubuntu
RUN apt-get update -y
RUN apt-get install nginx -y
CMD ["service", "nginx"," start"]


# Override CMD
FROM ubuntu
RUN apt-get update -y
RUN apt-get install nginx -y
CMD service nginx start && bash
# docker run -it <container id> (any linux command top,ls,ls -a,sleep 5)
------------------------------------------------------------------------
# Entrypoint

FROM ubuntu
RUN apt-get update -y
RUN apt-get install nginx -y
ENTRYPOINT  service nginx start && bash 
# override Entrypoint 
# command to override Entrypoint
# docker run --entrypoint -it <container id> (any linux command top,ls,ls -a,sleep 5)
# docker run -it --entrypoint top 87234

--------------------------------------------------------------
# Multi Shell command

FROM ubuntu
RUN apt-get update \
    && apt-get install -y nginx \
    && apt-get install -y curl \
    && mkdir -p /app \
    && touch /app/new.file

CMD ["sh", "-c", "echo 'Hello' > app/new.file  && ls /app"]
--------------------------------------------------------------
# Shell Scripting
#vi setup.sh

#!/bin/bash
mkdir -p /app
touch /app/new.file
echo 'Hello this is docker day two' > /app/new.file
ls /app


FROM ubuntu
COPY setup.sh /setup.sh
RUN apt-get update \
    && apt-get install -y nginx \
    && apt-get install -y curl \
    && chmod +x /setup.sh
CMD ["/setup.sh"]

--------------------------------------------------------------------
# Multi Stage Dockerfile

FROM maven:latest AS build
WORKDIR /app
COPY . /app
RUN mvn clean package

# Stage 2: Production Stage
FROM tomcat:latest
COPY --from=build /app/target/sample.war /usr/local/tomcat/webapps/sample.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
===========================================


