#!/bin/bash

# Update the package repository
sudo apt update -y

# Install nginx
sudo apt install nginx -y

# Start and enable the service
sudo systemctl enable nginx
sudo systemctl start nginx

# Get the private IP address of the server
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
PRIVATE_IP=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/local-ipv4)
PUBLIC_IP=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/public-ipv4)


# Create the main HTML file
echo "<h1>Ecommerce - B2B Service - Server deployed with Terraform</h1>" | sudo tee /var/www/html/index.html

# Create another HTML file for a secondary app
sudo mkdir -p /var/www/html/b2b
echo '<!DOCTYPE html> 
<html> 
  <body style="background-color:rgb(250, 210, 210);"> 
    <h1>Ecommerce - B2B Service</h1> 
    <p>Terraform Demo</p> 
    <p>Application Version: V1</p> 
  </body>
</html>' | sudo tee /var/www/html/b2b/index.html

# Get the instance metadata
sudo curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/dynamic/instance-identity/document -o /var/www/html/b2b/metadata.json
