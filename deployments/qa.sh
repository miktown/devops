npm i -g now
echo "deploying..."
URL=$(now --docker -t $NOW)
echo "running acceptance on $URL"
curl --silent -L $URL