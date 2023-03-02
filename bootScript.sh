#!/bin/bash
echo "$(date)"' 🥾 >>> bootScript.sh' >> ~/log.txt
docker compose --profile auto up --build > tmpOutput.txt &
source scan.sh
wait