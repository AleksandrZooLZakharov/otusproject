#!/bin/bash
set -e

echo "start install##########################################################################"
# если руками, то из под root на новом сервере выполнить (добавил 3 последних sudo)
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update

echo "###docker-compose installing#############################################################################"

sudo apt-get install docker-ce docker-compose -y

echo "!!!docker-compose installed!!!##########################################################################"

sudo mkdir -p /srv/gitlab/config /srv/gitlab/data /srv/gitlab/logs
cd /srv/gitlab/

echo "mkdir+cd - done, starting printf##########################################################################"

sudo bash -c 'printf \
"web:\n\
  image: \"gitlab/gitlab-ce:latest\"\n\
  restart: always\n\
  hostname: \"gitlab.example.com\"\n\
  environment:\n\
    GITLAB_OMNIBUS_CONFIG: |\n\
      external_url \"http://%s/\"\n\
  ports:\n\
    - \"80:80\"\n\
    - \"443:443\"\n\
    - \"2222:22\"\n\
  volumes:\n\
    - \"/srv/gitlab/config:/etc/gitlab\"\n\
    - \"/srv/gitlab/logs:/var/log/gitlab\"\n\
    - \"/srv/gitlab/data:/var/opt/gitlab\"\n" "$(curl ifconfig.me/ip)" > docker-compose.yml' 

echo "ALL PREPARATIONS IS DONE!##########################################################################"


sudo gpasswd -a $USER docker #&& newgrp docker

echo "groups done"

sudo service docker restart

echo "docker service restarted"

pwd

echo "Ready to Docker-compose kick-start! )"
#sleep 500

sudo docker-compose up -d



