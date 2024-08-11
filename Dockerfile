FROM ubuntu:latest

# Install necessary packages
RUN apt-get update && \
    apt-get install -y curl openssh-client gnupg apt-transport-https

# Add the PufferPanel repository
RUN curl -s https://packagecloud.io/install/repositories/pufferpanel/pufferpanel/script.deb.sh | bash

# Install PufferPanel
RUN apt-get update && \
    apt-get install -y pufferpanel

# Enable PufferPanel service
RUN systemctl enable --now pufferpanel

# Create the PufferPanel user
RUN pufferpanel user add --email foxytoux@gmail.com --name foxytoux --password Fox21200 --admin

# Expose the port for PufferPanel
EXPOSE 8080 5657

# Entrypoint: start PufferPanel service (optional)
# ENTRYPOINT ["/bin/bash", "-c", "systemctl start pufferpanel"]
