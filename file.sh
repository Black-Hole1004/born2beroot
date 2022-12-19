Architecture=$(uname -a)
CPU_PH=$(lscpu | grep "Socket(s)" | awk '{print $NF}')
CPU_V=$(lscpu | grep "Socket(s)" | awk '{print $NF}')
Mem_U=$(free -m | grep Mem | awk '{printf("%d/%dMB (%.2f)%%", $3, $2, $3 * 100/$2)}')
Disk_U=$(df -h --total | grep total | awk '{printf("%.1f/%.fGb (%.2f)%%", $3,$2,$3*100/$2)}')
CPU_LOAD=$(top -bn1 | grep load | awk '{printf("%.2f%%",$(NF-2))}')
Last_boot=$(who -b | awk '{printf("%s %s", $(NF-1) , $NF)}')
check_lvm=$(lsblk | grep lvm)
if [ -z "$check_lvm"]
	then
		LVM_USE="NO"
else
		LVM_USE="YES"
fi
NUM_CONN=$(netstat -an | grep ESTABLISHED | wc -l)
UM_USERS_SERV=$(who | wc -l)
IP_MAC=$(hostname -I | tr '\n' ' '; ip a | grep ether | awk '{printf("(%s)", $(NF-2))}')
NUM_COM=$(sudo cat /var/log/sudo/sudo.log | grep COMMAND | wc -l)

echo "#Architecture: $Architecture\n"\
"#CPU physical : $CPU_PH\n"\
"#vCPU : $CPU_V\n"\
"#Memory Usage: $Mem_U\n"\
"#Disk Usage: $Disk_U\n"\
"#CPU load: $CPU_LOAD\n"\
"#Last boot: $Last_boot\n"\
"#LVM use: $LVM_USE\n"\
"#Connections TCP : $NUM_CONN\n"\
"#User log: $UM_USERS_SERV\n"\
"#Network: IP $IP_MAC\n"\
"#Sudo : $NUM_COM cmd" | wall
