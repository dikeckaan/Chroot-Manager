#!/bin/bash 

OSNAME=ubuntu-x64
OSVERSION=Focal

clear

echo "Ubuntu $OSVERSION should install"
echo "Target OSNAME is $OSNAME"



rm -rf "/srv/chroot/ubuntu-x64"
apt update
apt install -y qemu-user-static schroot debootstrap
cp /usr/bin/qemu-x86_64-static /srv/chroot/$OSNAME/usr/bin
debootstrap --arch amd64 --foreign focal /srv/chroot/ubuntu-x64
chroot "/srv/chroot/ubuntu-x64/" /debootstrap/debootstrap --second-stage


rm /etc/schroot/chroot.d/ubuntux64.conf
tee -a /etc/schroot/chroot.d/ubuntux64.conf << EOF
[ubuntu-x64]
description=Ubuntu Focal x64 chroot
aliases=ubuntu-x64
type=directory
directory=/srv/chroot/ubuntu-x64
profile=desktop
personality=linux
preserve-environment=true
EOF


echo "Operation has been finished, you can run it any time : schroot -c ubuntu-x64"
echo "If you want reinstall, just re-run this script" 



hour=0
 min=0
 sec=15
        while [ $hour -ge 0 ]; do
                 while [ $min -ge 0 ]; do
                         while [ $sec -ge 0 ]; do
                                 echo -ne "schroot will start $hour:$min:$sec\033[0K\r"
                                 let "sec=sec-1"
                                 sleep 1
                         done
                         sec=59
                         let "min=min-1"
                 done
                 min=59
                 let "hour=hour-1"
         done
		 

schroot -c ubuntu-x64
