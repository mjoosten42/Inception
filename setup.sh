apk add make curl git docker docker-cli-compose
mkdir /home/mjoosten
git clone https://github.com/mjoosten42/Inception /home/mjoosten
service docker start
echo 127.0.0.1 mjoosten.42.fr >> /etc/hosts
