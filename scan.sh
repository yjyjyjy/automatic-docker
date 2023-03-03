#!/bin/bash
cd /home/ubuntu/automatic-docker/
echo "$(date)"' 👀 >>> scan.sh' >> /home/ubuntu/log.txt
id=`/bin/ec2metadata | awk '/instance-id/ {printf $2}'`
ip=`/bin/ec2metadata | awk '/public-ipv4/ {printf $2}'`
echo "$(date)"' 👀 instanceId: '"$id" >> /home/ubuntu/log.txt
echo "$(date)"' 👀 publicIp: '"$ip" >> /home/ubuntu/log.txt
URL=""
while true
do
  URL=`awk '/Running on public URL: / {printf $7}' tmpOutput.txt`
  if [ "$URL" != "" ]
  then
    echo "$(date)"' 👀 URL: '"$URL" >> /home/ubuntu/log.txt
    cmd=$(curl -v -d '{"gradioLink":"'"$URL"'", "ip":"'"$ip"'"}' -H "Content-Type: application/json" -X PUT https://a1-rouge.vercel.app/api/instance/$id)
    break
  else
    sleep 1
  fi
done