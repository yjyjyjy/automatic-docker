#!/bin/bash
cd /home/ubuntu/automatic-docker/
echo "$(date)": πuser:"$USER"' π >>> scan.sh' >> /home/ubuntu/log.txt
id=`/bin/ec2metadata | awk '/instance-id/ {printf $2}'`
ip=`/bin/ec2metadata | awk '/public-ipv4/ {printf $2}'`
userId=`aws ec2 describe-tags --filters Name=key,Values=userId Name=resource-id,Values=i-076116efb3d37ada4 | jq -r '.Tags[0].Value'`
storage=`aws ec2 describe-tags --filters Name=key,Values=storage Name=resource-id,Values=i-076116efb3d37ada4 | jq -r '.Tags[0].Value'`
stackId=`aws ec2 describe-tags --filters Name=key,Values=aws:cloudformation:stack-id Name=resource-id,Values=i-076116efb3d37ada4 | jq -r '.Tags[0].Value'`
launchTemplateId=`aws ec2 describe-tags --filters Name=key,Values=aws:ec2launchtemplate:id Name=resource-id,Values=i-076116efb3d37ada4 | jq -r '.Tags[0].Value'`
echo "$(date)"' π instanceId: '"$id" >> /home/ubuntu/log.txt
echo "$(date)"' π publicIp: '"$ip" >> /home/ubuntu/log.txt
echo "$(date)"' π userId: '"$userId" >> /home/ubuntu/log.txt
echo "$(date)"' π storage: '"$storage" >> /home/ubuntu/log.txt
echo "$(date)"' π stackId: '"$stackId" >> /home/ubuntu/log.txt
echo "$(date)"' π launchTemplateId: '"$launchTemplateId" >> /home/ubuntu/log.txt
URL=""
while true
do
  URL=`awk '/Running on public URL: / {printf $7}' tmpOutput.txt`
  if [ "$URL" != "" ]
  then
    echo "$(date)"' π URL: '"$URL" >> /home/ubuntu/log.txt
    cmd=$(curl -v -d '{"gradioLink":"'"$URL"'", "ip":"'"$ip"'", "userId":"'"$userId"'", "storage":"'"$storage"'", "stackId":"'"$stackId"'", "launchTemplateId":"'"$launchTemplateId"'"}' -H "Content-Type: application/json" -X PUT https://a1-rouge.vercel.app/api/instance/$id)
    break
  else
    sleep 1
  fi
done