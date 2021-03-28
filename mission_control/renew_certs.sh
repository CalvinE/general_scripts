echo "go to mission control directory"
cd /root/mission_control
echo "take down containers"
docker-compose -f docker-compose.dev.yml -f docker-compose.prod.yml down
echo "move to root home folder"
cd /root
echo "renew certificates"
certbot renew
echo "copy certs to sslcert folder"
cp -vf  /etc/letsencrypt/live/mc.smitesystems.com/* ./sslcerts/
echo "move to mission control directory"
cd /root/mission_control
echo "restart docker containers"
docker-compose -f docker-compose.dev.yml -f docker-compose.prod.yml up -d