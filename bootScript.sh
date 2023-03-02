#!/bin/bash
docker compose --profile auto up --build > tmpOutput.txt &
source scan.sh
wait