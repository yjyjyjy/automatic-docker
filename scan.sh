#!/bin/bash
cd /home/ubuntu/automatic-docker/
echo "$(date)"' 👀 >>> scan.sh' >> /home/ubuntu/log.txt
id=`/bin/ec2metadata | awk '/instance-id/ {printf $2}'`
ip=`/bin/ec2metadata | awk '/public-ipv4/ {printf $2}'`
echo "$(date)"' 👀 instanceId: '"$id" >> /home/ubuntu/log.txt
URL=""
while true
do
  URL=`awk '/Running on public URL: / {printf $7}' tmpOutput.txt`
  if [ "$URL" != "" ]
  then
    echo "$(date)"'👀 URL: '"$URL" >> /home/ubuntu/log.txt
    cmd=$(curl -d '{"instanceId":"'"$id"'", "gradioEndpoint":"'"$URL"'", "publicIp":"'"$ip"'"}' -H "Content-Type: application/json" -X POST https://a1-rouge.vercel.app/api/instance/register)
    break
  else
    sleep 1
  fi
done