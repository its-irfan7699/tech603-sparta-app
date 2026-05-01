#!/bin/bash

# Purpose: Provision Mongo DB v8.2.5 for Sparta Tic Tac Toe application
# Testing on: AWS, Ubuntu 24.04 LTS
# Planning for it to work on: New VM and run it multiple times
# Tested by: irfan
# Tested when: 30/4/26

#once we start a new instance we need to update and upgrade the system, then we will install mongodb and configure it to allow connections from any IP address so that our application can connect to it
echo "update..."
sudo apt-get update
echo done!
echo

# upgrade the system to get the latest security updates and bug fixes
echo "upgrade..."
sudo apt-get upgrade -y
echo done!
echo

# install gnupg to add the mongodb gpg key, this command will install gnupg if it's not already installed, and if it is already installed it will just skip it and move on to the next command
echo "install gnupg..."
sudo apt-get install -y gnupg
echo done!

# add the mongodb gpg key to the system, this key is used to verify the authenticity of the mongodb packages that we will install later, this command will download the gpg key from the mongodb website and add it to the system's keyring, this is necessary to ensure that the packages we install are from a trusted source and have not been tampered with 
curl -fsSL https://pgp.mongodb.com/server-8.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-8.0.gpg \
   --dearmor

# add the mongodb source list file to the system, this file contains the information about the mongodb packages that we will install later, this command will create a new file in the /etc/apt/sources.list.d/ directory with the name mongodb-org-8.2.list and add the mongodb source list to it, this is necessary to tell the system where to find the mongodb packages when we run the apt-get install command later
echo "create mongodb source list file..."
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] https://repo.mongodb.org/apt/ubuntu noble/mongodb-org/8.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-8.2.list
echo done!

# once we add the source list file we need to update the system again to get the latest information about the packages that we will install later, this command will update the package list and allow us to install the mongodb packages in the next step
echo "update again after adding mongodb source list..."
sudo apt-get update
echo done!

# install mongodb-org package, this command will install the mongodb-org package and all its dependencies, this package contains the mongodb server, database, mongosh, mongos and tools, we specify the version 8.2.5 to ensure that we install the correct version of mongodb that is compatible with our application
echo "install mongodb-org..."
sudo apt-get install -y mongodb-org=8.2.5 mongodb-org-database=8.2.5 mongodb-org-server=8.2.5 mongodb-mongosh mongodb-org-mongos=8.2.5 mongodb-org-tools=8.2.5
echo done!
echo


# configure bind IP to allow connections from any IP address, this is necessary to allow our application to connect to the mongodb server, by default mongodb binds to the localhost IP address (127.0.0.1)
echo "configure bind IP..."
sudo sed -i 's/bindIp: 127.0.0.1/bindIp: 0.0.0.0/' /etc/mongod.conf
echo done!
echo


# once we change the bind IP we need to restart the mongodb service to apply the changes, this command will restart the mongod service and allow it to listen on all IP addresses
echo "restart mongod..."
sudo systemctl restart mongod
echo done!
echo


# once we restart mongodb we need to enable the mongod service to it enables the mongo db, as when we start it above it doesnt enable it.
echo "enable mongod..."
sudo systemctl enable mongod # this command will enable the mongod service to start automatically when the system boots up, this is necessary to ensure that our application can connect to the mongodb server even after a reboot
echo done!
echo
#sudo systemctl status mongod # this command will show the status of the mongod service, we should see that it is active and running, if there are any issues with starting the service we can check the logs to see what went wrong



