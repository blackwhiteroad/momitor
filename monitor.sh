#!/bin/bash
#auth yangxingyi 2017-12-12 17:50
#email openweixin666@126.com
#this script  check cpu used rate and memory used rate
#userEmail="269754243@qq.com openweixin666@126.com"
#webIp="www101.200.***.***"
memorySetting="10"
cpuSetting="10"
#check memory used rate 
totalMemory=$(free -m|awk  '{print $2}'|sed -n '2p')
usedMemory=$(free -m|awk  '{print $3}'|sed -n '2p')
freeMemory=$(free -m|awk  '{print $4}'|sed -n '2p')
usedPerMemory=$(awk 'BEGIN{printf "%.0f",('$usedMemory'/'$totalMemory')*100}')
freePerMemory=$(awk 'BEGIN{printf "%.0f",('$freeMemory'/'$totalMemory')*100}')
if [ $usedPerMemory -ge $memorySetting  ];then
     minfo="totalMemory:$totalMemory MB,used:$usedMemory MB,free:$freeMemory MB,usedPercent:$usedPerMemory%,freePrecent:$freePerMemory%"
     echo "$(date) $minfo used memory was gt $memorySetting% !" >> log_hard_disk_check
#     echo " $minfo {$webIp}!" | mail -s "{$webIp} used memory was high!"  $userEmail
fi
#check cpu used rate
cpuUsed=$(top -n 1 | sed -n '3p' | awk '{printf "%.0f",$2}')
if [ $cpuUsed -gt $cpuSetting ];then
     echo "$(date) cpu used $cpuUsed%"
#      echo  "$(date) cpu used $cpuUsed%"|mail -s "$webIp cpu used $cpuUsed%" $userEmail
fi

#注释:
#该脚本检测cpu和内存的使用情况,只需要调整memorySetting、cpuSetting、userEmail要发邮件报警的email地址即可 
#如果没有配置发邮件参数的哥们,已配置了的,直接飞到代码区: 
#1.vim /etc/mail.rc 
#2.找到以下内容 
#set from=yangxingyi@duoduofenqi.com #来自什么 
#set smtp=smtp.exmail.qq.com #根据您的邮箱发件服务器填写,我这位是TX的企业邮箱 
#set smtp-auth-user=yangxingyi@duoduofenqi.com #邮箱用户名 
#set smtp-auth-password=您的密码 #注意是发邮件密码,有的邮箱服务商登陆密码和发件密码不一样的哦 
#set smtp-auth=login 
#**配置完成后可以直接echo ‘test content’ |mail -s ‘test title’ yangxingyi@duoduofenqi.com 
#如果收到邮件,说明您邮件配置是ok的,否则就是有见没配置好哦,重新检查用户名密码,smtp有没有填错!!!** 

#shell脚本-监控CPU/内存/硬盘使用率
##!/bin/sh
#free -m | awk 'NR==2{printf "Memory Usage: %s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }'
##Memory Usage: 14030/15768MB (88.98%)
#df -h | awk '$NF=="/"{printf "Disk Usage: %d/%dGB (%s)\n", $3,$2,$5}'
##Disk Usage: 24/118GB (21%)
#top -bn1 | grep load | awk '{printf "CPU Load: %.2f\n", $(NF-2)}'
##CPU Load: 2.55


