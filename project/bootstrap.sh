#!/bin/bash
user="udacity"
password="Udacity123456"
sql_query="CREATE DATABASE api_logger;"
echo "Gathering requirements."
sudo apt update && sudo apt upgrade -y && sudo apt install git nginx python3 python3-pip python3-virtualenv nginx supervisor -y
echo "Gathering requirements completed."
echo "Installing database."
wget --directory-prefix=/tmp https://dev.mysql.com/get/mysql-apt-config_0.8.13-1_all.deb
sudo dpkg -i /tmp/mysql-apt-config*
sudo apt update && apt install mysql-server -y
mysql -u "root" -p"$password" -e "$sql_query"
echo "Installing database completed."
echo "Installing flask app."
cd ~
mkdir app
cd app
mkdir api-env
git clone https://github.com/udacity/cd0028-Observing-Cloud-Resources.git
touch ~/app/example_flask_api/dbcreds.yaml
cat >~/app/example_flask_api/dbcreds.yaml <<EOL
db_user:  root
db_pass:  ${password}
db_host:  127.0.0.1
db_port:  3036
db_name:  api_logger
EOL
cd ~/app/example_flask_api/
sudo pip3 install -r requirements.txt
sudo pip3 install gunicorn
cat >/etc/supervisor/conf.d/example_api.conf <<EOL
[program:example_api]
directory=/home/${user}/app/example_flask_api/api
command=gunicorn --workers=4 --log-level=debug main_api:api -b localhost:8000
autostart=true
autorestart=true
stderr_logfile=/var/log/api/api.err.log
stdout_logfile=/var/log/api/api.out.log
EOL
sudo mkdir /var/log/api
sudo touch /var/log/api/api.err.log
sudo touch /var/log/api/api.out.log
sudo supervisorctl reread
sudo service supervisor restart
sudo supervisorctl restart all
sudo supervisorctl status