#!/bin/bash
#
#
#

OUT=/tmp/enumeration


# Enumeration command no 1: current users, groups, and privileges
id &> $OUT/enum1

# Enum command 2: running processes 
ps auxf &> $OUT/enum2

# Enum command 3: open network sockets 
sudo lsof -i -P -n &> $OUT/enum3

# Enum command 4: all running services
systemctl status &> $OUT/enum4

#enum 5: all local user accounts
cut -d: -f1 /etc/passwd > $OUT/enum5

#enum 6: all localgroups
cut -d: -f1 /etc/group > $OUT/enum6

#enum 7: users in the sudo group
grep adm /etc/group | cut -d: -f4 > $OUT/enum7

#enum 8: current network configuration
ip a > $OUT/enum8
cat /etc/resolv.conf >> $OUT/enum8 


#enum 9: firewall policies
sudo iptables-save > $OUT/enum9

#enum 10: arp table
arp -a &> $OUT/enum10


#enum 11: smbsessions
# by default smbstatus is not installed, using /proc/mounts instead, as it shows any mounts using cifs.
grep cifs /proc/mounts &> $OUT/enum11


#enum 12: systeminformation
#
uname -a > $OUT/enum12 # kernel and hostname info
cat /etc/os-release >> $OUT/enum12 #OS build info
free -h &>> $OUT/enum12 #memory info
cat /proc/cpuinfo &>> $OUT/enum12 #cpuinfo 




#enum 13: sudo priviliges granted to current user
#
sudo -l &> $OUT/enum13


#enum 14: currently logged in users + history
who -a &> $OUT/enum14

#enum 15: shell history of local users:
#
cat /home/*/.bash_history &> $OUT/enum15


#enum 16 env of current shell and running_processes
#
for i in $(ps x -o pid --no-headers); do cat /proc/$i/environ &> $OUT/enum16.pid_$i; done


#enum 17 suid & sgid binaries 
find / -perm -u+srx -or -perm -g+srx 2> /dev/null > $OUT/enum17



#enum 18 file capabilities assigned to installed binaries
#
for i in $(echo $PATH | tr ':' '\n'); do find $i -type f -exec stat {} \; &> $OUT/enum16 ; done

#enum 19 schedled cron jobs & systemd timers

systemctl list-timers --all &> $OUT/enum19
cat /etc/cron.d/* /etc/crontab >> $OUT/enum19


#enum 20 installed security tools & are they running
#
#
ps aux | grep -Ei 'clamav|auditd|falcon|crowdstrike|wazuh|ossec' | grep -v grep &> $OUT/enum20

#enum 21: all installed packages
#

apt list --installed &> $OUT/enum21

# enum 22: kernel version and build info
uname -srvi &> $OUT/enum22

#enum 23: mounted filesystems and free disk space
lsblk --fs &> $OUT/enum23

#enum 24: ssh-keys, authorized_keys files, and ssh_client/server config
#
cat /etc/ssh/* &> $OUT/enum24

#enum 25: /etc/shadow readibiltiy 

stat /etc/shadow &> $OUT/enum25

#enum26: authentication events
sudo lastb &> $OUT/enum26

#enum27: running containers
docker ps &> $OUT/enum27

#enum28 apparmor status
sudo apparmor_status > $OUT/enum28

#enum29: exported nfs shares
#
cat /etc/exports > $OUT/enum29
#enum30: hostname,fqdn
hostnamectl &> $OUT/enum30
#enums31: writable
find / -perm -a+rw | grep -v -E "sys|proc|home" > $OUT/enum31
#enums32 files opened by running processes
sudo lsof &> $OUT/enum32





