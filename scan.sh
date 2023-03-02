#!/bin/bash
id=`/bin/ec2metadata | awk '/instance-id/ {printf $2}'`
URL=""
while true
do
  URL=`awk '/Running on public URL: / {printf $7}' tmpOutput.txt`
  if [ "$URL" != "" ]
  then
    echo $URL
    cmd=$(curl -d '{"instanceId":"'"$id"'", "endpoint":"'"$URL"'"}' -H "Content-Type: application/json" -X POST https://a1-rouge.vercel.app/api/instance/register)
    break
  else
    sleep 1
  fi
done