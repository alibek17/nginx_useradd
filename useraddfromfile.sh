#!/bin/bash
# create accounts for users from a file userlist

sed -i 's/^%wheel/#%wheel/' /etc/sudoers
sed -i 's/^# %wheel/%wheel/' /etc/sudoers
file='userlist'
if [[ -f "$file" ]]
then
  while IFS=' ' read -r user key
  do
    useradd -G wheel $user
    mkdir /home/$user/.ssh
    echo "$key" >> /home/$user/.ssh/authorized_keys
  done<"$file"
else
  echo "The file userlist doesn't exist"
fi
