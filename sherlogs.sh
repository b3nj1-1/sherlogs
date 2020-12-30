#!/bin/bash
# Log in linux @b3nj1
# ./seclog.sh


#Colour
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

# variables
day=$(date +%A)
hostname=$(hostname -s)
here=$(pwd)
condition=$(id | awk '{print$1}')
date="$hostname-$day"
successful=$(echo $?)

echo "          _____           _______                   _____          "
sleep 0.05
echo "         /\    \         /::\    \                 /\    \   	 "
sleep 0.05
echo "        /::\____\       /::::\    \               /::\    \        "
sleep 0.05
echo "       /:::/    /      /::::::\    \             /::::\    \       "
sleep 0.05
echo "      /:::/    /      /::::::::\    \           /::::::\    \      "
sleep 0.05
echo "     /:::/    /      /:::/~~\:::\    \         /:::/\:::\    \     "
sleep 0.05
echo "    /:::/    /      /:::/    \:::\    \       /:::/  \:::\    \    "
sleep 0.05
echo "   /:::/    /      /:::/    / \:::\    \     /:::/    \:::\    \   "
sleep 0.05
echo "  /:::/    /      /:::/____/   \:::\____\   /:::/    / \:::\    \  "
sleep 0.05
echo " /:::/    /      |:::|    |     |:::|    | /:::/    /   \:::\ ___\ "
sleep 0.05
echo "/:::/____/       |:::|____|     |:::|    |/:::/____/  ___\:::|    |"
sleep 0.05
echo "\:::\    \        \:::\    \   /:::/    / \:::\    \ /\  /:::|____|"
sleep 0.05
echo " \:::\    \        \:::\    \ /:::/    /   \:::\    /::\ \::/    / "
sleep 0.05
echo "  \:::\    \        \:::\    /:::/    /     \:::\   \:::\ \/____/  "
sleep 0.05
echo "   \:::\    \        \:::\__/:::/    /       \:::\   \:::\____\    "
sleep 0.05
echo "   \:::\    \        \::::::::/    /         \:::\  /:::/    /    "
sleep 0.05
echo "     \:::\    \        \::::::/    /           \:::\/:::/    /     "
sleep 0.05
echo "      \:::\    \        \::::/    /             \::::::/    /      "
sleep 0.05
echo "       \:::\____\        \::/____/               \::::/    /       "
sleep 0.05
echo "        \::/    /         ~~                      \::/____/        "
sleep 0.05
echo "         \/____/                                                   "
echo "                                                                   "
sleep 0.05
echo -e "${greenColour}(B3NJ1)${endColour}"
echo ""
sleep 0.05
echo -e "\n${grayColour}[*]You are in $here${endColour}"
echo -e "\n${grayColour}[*]The log will be saved in /home${endColour}"
echo -e "\n${grayColour}[*]You have to run the script with privileges $condition${endColour}"
echo -e "\n${grayColour}[*]If you don't meet the conditions ${endColour}"
sleep 2

function log(){
mkdir logs
# Lectura de logs
cat /var/log/messages | tail -n 10 > log.principal
cat /var/log/httpd/access_log | tail -n 10 > log.apache 2>/dev/null
cat /var/log/httpd/error_log | tail -n 10 > log.apache_error 2>/dev/null
cat /var/log/firewalld | tail -n 10 > log.firewalld 2>/dev/null
cat /var/log/secure | tail -n 10 > log.auth
cat /var/log/boot.log | tail -n 10 > log.boot 2>/dev/null
cat /var/log/wtmp | strings -n 10 | grep -v 4. | tail -n 10 > log.logins 2>/dev/null
cat /var/log/btmp | strings -n 10 | tail -n 10 > log.fail-login 2>/dev/null
echo "[*]These IPs got connected" >> log.logins 2>/dev/null
echo "[*]These IPs were logged in incorrectly" >> log.fail-login 2>/dev/null
cat /var/log/cron | tail -n 20 > log.cronjob 2>/dev/null
# If you have the sql service you can activate this option
# cat /var/log/mysqld.log | tail -n 10 > log.mysql 2>/dev/null
cat /var/log/maillog | tail -n 10 > log.mail 2>/dev/null

# Moviendo los logs
mv {log.principal,log.apache,log.apache_error,log.firewalld,log.auth,log.boot,log.fail-login,log.mail,log.cronjob,log.logins,log.mysql} logs/ 2>/dev/null
tar cf logs.tar logs/ 2>/dev/null
mv logs.tar /home/
sleep 5

# Borrando
rm -rf logs/


echo -e "\n${grayColour}[*]Log $date${endColour}"
}

# Para matar el proceso
function kill(){
	kill % 2>/dev/null
}

# Condiciones
if [ "$condition" == "uid=0(root)" ]; then
	echo -e "\n${grayColour}[*]Condition met${endColour}"
	log
	chmod 774 /home/logs.tar
	echo -e "\n${grayColour}[*]Permiso Cambiado${endColour}"
else
	echo -e "\n${grayColour}[*]Condition not met${endColour}"

fi
