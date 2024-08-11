FROM ubuntu:latest

# Set environment variables for non-interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && \
    apt-get install -y curl openssh-client gnupg apt-transport-https && \
    apt-get install systemctl -y

# Download and install systemctl3.py
RUN curl -o /bin/systemctl https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/master/files/docker/systemctl3.py && \
    chmod -R 777 /bin/systemctl

# Add the PufferPanel repository
RUN curl -s https://packagecloud.io/install/repositories/pufferpanel/pufferpanel/script.deb.sh | bash

# Install PufferPanel
RUN apt-get update && \
    apt-get install -y pufferpanel

# Enable PufferPanel service
RUN systemctl enable --now pufferpanel

# Create the PufferPanel user
RUN pufferpanel user add --email foxytoux@gmail.com --name foxytoux --password Fox21200 --admin

# Install docker.io, git, python3, and pip
RUN apt-get update && apt-get install -y docker.io git python3 python3-pip

# Expose the port for PufferPanel
EXPOSE 8080 5657

# Entrypoint: start PufferPanel service (optional)
# ENTRYPOINT ["/bin/bash", "-c", "systemctl start pufferpanel"]
