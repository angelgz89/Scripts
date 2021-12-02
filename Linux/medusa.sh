#!/bin/bash

#####################################################
# To run, simply: chmod +x medusa.sh && ./medusa.sh #
#####################################################

# Successful publickey connections
echo '==== Successful SSH Public Key Connections ===='
CONNECTIONS=`grep "sshd.*Accepted publickey" /var/log/auth.log`
while read -r line; do
    echo $line;
done <<< "$CONNECTIONS"
echo ''

# Watch for sudo actions
echo '==== Recent Sudo Actions ===='
SUDOS=`grep "sudo.*TTY" /var/log/auth.log`
while read -r line; do
    echo $line;
done <<< "$SUDOS"
echo ''

# Show failed brute force attempts
echo '==== Potential Brute Force Attempts ===='
BRUTE=`grep sshd.\*Failed /var/log/auth.log`
while read -r line; do
    echo $line;
done <<< "$BRUTE"
echo ''

# Potential port scanners
echo '==== Potential Port Scanners ===='
SCANNERS=`grep sshd.*Did /var/log/auth.log`
while read -r line; do
    echo $line;
done <<< "$SCANNERS"
echo ''
