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
