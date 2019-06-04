#!/bin/bash
for user in $(ls /home)
do
password=$(date +%s | sha256sum | base64 | head -c 32 ; echo)
ssh -i /ssh_keys/app_rsa centos@elk.hostname.com << EOF
echo '$user:`openssl passwd -apr1 $password`' | sudo tee -a /etc/nginx/htpasswd.users
EOF
printf "username: $user\npassword: $password\n">/home/$user/elk_acess
done
