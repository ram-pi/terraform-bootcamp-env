#!/bin/bash

sudo apt update -y
sudo apt-get install python3-distutils -y
sudo apt install python3-pip -y 
sudo apt install silversearcher-ag jq haproxy unzip openjdk-11-jdk -y
sudo apt install software-properties-common -y
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt update
sudo apt install ansible -y
