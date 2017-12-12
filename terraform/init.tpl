# variable from terraform
export DBHOST=${db_host}

# installing docker and docker-compose
apt-get update
apt-get -qq install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
apt-get update
apt-get install docker-ce
apt-get install python-pip
pip install docker-compose

# get repo
git clone https://github.com/StToupin/simple-php-app.git
cd simple-php-app

# start server
apt-get install mysql-client
docker-compose up -d
mysql -u duoquadra -p -D training42 -h $DBHOST -P 3306 < sql/fixtures.sql
