#!/bin/bash
printf "Please enter the list of the users, seperated by space, for whom you want to generate the password\nor enter everyone to generate a password for all users\n"
read userlist
printf "Please enter the name of the file that will be created in users home directory\n"
read filename
if [ "$userlist" == "everyone" ]
then
    for user in $(ls /home)
    do
    password=$(date +%s | sha256sum | base64 | head -c 32 ; echo)
    printf "username: $user\npassword: $password\n" | sudo tee /home/$user/$filename
    done
else
    IFS=' ' read -r -a user_array <<< "$userlist"
    for user in "${user_array[@]}"
    do
        if [ -d "/home/$user" ]
        then
            password=$(date +%s | sha256sum | base64 | head -c 32 ; echo)
            printf "username: $user\npassword: $password\n" |sudo  tee /home/$user/$filename
        else
            printf "username: $user doesn't exist\n"
        fi
    done
fi
