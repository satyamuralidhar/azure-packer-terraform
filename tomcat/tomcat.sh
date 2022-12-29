#!/bin/bash
sudo yum install java-1.8.0-openjdk-devel -y
sudo yum install tomcat -y
sudo yum update -y
sudo service tomcat restart
sudo service tomcat status