#!/bin/bash
cd /home/ubuntu/automatic-docker/
echo "$(date)": 😃user:"$USER"' 🥾 >>> bootScript.sh' >> /home/ubuntu/log.txt
docker compose --profile auto up --build > tmpOutput.txt &
source scan.sh
wait