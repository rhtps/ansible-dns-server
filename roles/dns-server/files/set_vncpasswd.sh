#!/bin/sh

username="osebastion"
password="0SEB@stion"

mkdir /home/$username/.vnc
echo $password | vncpasswd -f > /home/$username/.vnc/passwd
chown -R $username:$username /home/$username/.vnc
chmod 0600 /home/$username/.vnc/passwd