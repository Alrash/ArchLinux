#! /usr/bin/sh


IP="your ip address"
PORT="port"
DIR="pack_transfer"
WEBUSER='www-data'

# 安装
sudo apt install python3-certbot-nginx nginx apache2 mysql-server php-mysql php-fpm -y

if [ ! -f "pack.tar.gz" ]; then
    scp -P $PORT alrash@$IP:"~/pack.tar.gz" .
fi
tar zxvf pack.tar.gz

cd $DIR
# 还原文件
sudo cp -rf * /

# 修正权限
WEBDAV_PATH=`head -n 1 .conf`
sudo chown -R $WEBUSER:$WEBUSER $WEBDAV_APTH
sudo chown $WEBUSER:$WEBUSER /etc/apache2/.htpasswd
sudo chmod 644 /etc/apache2/.htpasswd
sudo chmod 755 /usr/bin/frps

# 创建ssl证书
sudo certbot certonly -d alrash.xyz -m kasukuikawai@gmail.com --agree-tos --standalone

# 开启启动
sudo systemctl enable letsencrypt.timer
sudo systemctl start letsencrypt.timer
sudo systemctl enable nginx
sudo systemctl start nginx
sudo systemctl enable apache2
sudo systemctl start apache2
sudo systemctl enable frps
sudo systemctl start frps
