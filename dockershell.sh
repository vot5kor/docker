#!/bin/bash

# Script to install, start, and enable Docker on RHEL 9
# Exit immediately if any command fails
set -e

# Install required dependencies
echo "Installing dependencies..."
sudo dnf -y install dnf-plugins-core
    
# Add Docker's official repository
echo "Adding Docker's repository..."
sudo dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo -y

# Install Docker Engine
echo "Installing Docker Engine..."
sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# Start Docker service
echo "Starting Docker service..."
sudo systemctl start docker

# Enable Docker to start on boot
echo "Enabling Docker to start on boot..."
sudo systemctl enable docker

# Verify Docker installation
echo "Verifying Docker installation..."
sudo docker --version

# Add the current user to the Docker group (optional)
echo "Adding the current user to the Docker group..."
sudo usermod -aG docker $USER

# Notify the user to log out and back in for group changes to take effect
echo "Docker installation and setup complete!"
echo "Please log out and back in for the Docker group changes to take effect."