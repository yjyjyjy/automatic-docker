#!/bin/bash
docker compose --profile auto up --build > tmpOutput.txt &
./scan.sh
wait