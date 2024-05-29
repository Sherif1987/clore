tw_address=$1
alias=$2
thread=$3

url="https://api.teamwork.su/q/address/$tw_address"
q_address=$(curl -sSL "$url")

mkdir /www.TeamWork.su && cd /www.TeamWork.su
package=qli-Client-1.9.7-Linux-x64.tar.gz
wget -4 -O $package https://dl.qubic.li/downloads/$package
tar -xzvf $package
mkdir /www.TeamWork.su/TeamWork.su_CPU
cp /www.TeamWork.su/qli-Client /www.TeamWork.su/TeamWork.su_CPU/tw_cpu

echo "{\"Settings\": { \"amountOfThreads\": $thread, \"allowHwInfoCollect\": true, \"baseUrl\": \"https://mine.qubic.li/\", \"payoutId\": \"$q_address\", \"alias\": \"${alias}_CPU\"}}" > /www.TeamWork.su/TeamWork.su_CPU/appsettings.json

cat >> /etc/supervisor/supervisord.conf <<\eof

[program:tw_cpu]
command=/www.TeamWork.su/TeamWork.su_CPU/tw_cpu
directory=/www.TeamWork.su/TeamWork.su_CPU
autostart=true
autorestart=true
stdout_logfile=/dev/fd/1
stdout_logfile_maxbytes=0
eof
fi

supervisorctl reload
