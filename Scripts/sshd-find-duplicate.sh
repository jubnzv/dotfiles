#!/bin/bash
awk '{print $1}' /etc/ssh/sshd_config | sort | uniq -c | grep -v ' 1 ' 
