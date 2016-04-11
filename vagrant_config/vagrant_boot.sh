#!/usr/bin/env bash

echo "---------------------------------------------------------------"
echo "BOOTING SCRIPT"
echo "---------------------------------------------------------------"


echo "Starting MailHog"
nohup mailhog > /dev/null 2>&1 &

echo "Configuring iptables"
iptables -F