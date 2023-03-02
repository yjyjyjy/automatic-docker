#!/bin/bash
echo "$(date)"' 👀 >>> scan.sh' >> ~/log.txt
id=`/bin/ec2metadata | awk '/instance-id/ {printf $2}'`
echo "$(date)"' 👀 instanceId: '"$id" >> ~/log.txt
URL=""
while true
do
  URL=`awk '/Running on public URL: / {printf $7}' tmpOutput.txt`
  if [ "$URL" != "" ]
  then
    echo "$(date)"'👀 URL: '"$URL" >> ~/log.txt
    cmd=$(curl -d '{"instanceId":"'"$id"'", "endpoint":"'"$URL"'"}' -H "Content-Type: application/json" -X POST https://a1-rouge.vercel.app/api/instance/register)
    break
  else
    sleep 1
  fi
done