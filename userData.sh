#!/bin/bash
echo "Este es un mensaje de userData $(date) " >> ~/saludo.txt

yum update -y && yum install httpd -y
systemctl enable httpd
systemctl start httpd
