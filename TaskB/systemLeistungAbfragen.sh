#!/bin/bash

# Aktuelle Systemzeit
sysDate=$(date +"%T")

# Aktuelle Systemlaufzeit
sysUptime=$(uptime -p)

# Belegten und freien Speicher auf dem Dateisystem
output=$(df -h /mnt/c --output=size,used | tail -1)
size=$(echo $output | awk '{print $1}')
used=$(echo $output | awk '{print $2}')

# Hostname und IPv4-Adresse
hostname=$(hostname)
ipAdress=$(hostname -I | awk '{print $1}')

# Betriebssystemname und -version
osName=$(uname -s)
osVersion=$(cat /etc/os-release | grep "PRETTY_NAME=" | cut -d '"' -f 2)

# CPU-Modellname und Anzahl Cores
cpuName=$(grep -m 1 'model name' /proc/cpuinfo | awk -F: '{print $2}' | sed 's/^[ \t]*//')
cpuCores=$(grep -c ^processor /proc/cpuinfo)

# Der gesamte und der genutze Arbeitsspeicher
totalMemory=$(free -h --si | awk '/Mem:/ {print $2}')
usedMemory=$(free -h --si | awk '/Mem:/ {print $3}')

#Alle Informationen ausgeben
echo "+----------------------------------------------------------------+"
echo "|                        Systemleistungen                        |"
echo "+----------------------------------------------------------------+"
printf "| Akt. Syszeit       | %s\n| Akt. Syslaufzeit   | %s\n" "$sysDate" "$sysUptime"
printf "| Speicher           | %s\n| Davon genutzt      | %s\n" "$size" "$used"
printf "| Hostname           | %s\n| IPv4               | %s\n" "$hostname" "$ipAdress"
printf "| OS Name            | %s\n| OS Version         | %s\n" "$osName" "$osVersion"
printf "| CPU Name           | %s\n| CPU Cores          | %s\n" "$cpuName" "$cpuCores"
printf "| RAM                | %s\n| Davon genutzt      | %s\n" "$totalMemory" "$usedMemory"
echo "+----------------------------------------------------------------+"
