#!/bin/sh
hostfile="/etc/hosts"
hostname="recommend.match.sina.com.cn"
hostip=`dig ${hostname} +short|sed -n '1p'`
if [ -n "${hostip}" ]
then
	existhost=`grep ${hostname} ${hostfile}`
	if [ -n "${existhost}" ]
	then
		#update
		sed -i "s/[.0-9]\{7,15\} \(${hostname}\)/${hostip} \1/" ${hostfile}
	else
		#add
		sed -i "\$a${hostip} ${hostname}" ${hostfile}
	fi
fi
