#!/bin/bash
cd /home/ubuntu/automatic-docker/
echo "$(date)"' 🥾 >>> bootScript.sh' >> /home/ubuntu/log.txt
docker compose --profile auto up --build > tmpOutput.txt &
source scan.sh
wait