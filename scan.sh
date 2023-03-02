URL=""
while true
do
  URL=`awk '/Running on public URL: / {printf $7}' tmpOutput.txt`
  if [ "$URL" != "" ]
  then
    echo $URL
    break
  else
    sleep 1
  fi
done