#!/bin/sh
hostfile="/etc/hosts"
hostnames="recommend.match.sina.com.cn weibointra.match.sina.com.cn"
for hostname in ${hostnames};
do
	hostip=`dig ${hostname} +short|grep -E -o '([0-9]{1,3}[\.]){3}[0-9]{1,3}'|sed -n '1p'`
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
done
