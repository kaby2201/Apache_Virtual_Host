#!/bin/sh
# Create soulder
echo "How To Set Up Apache Virtual Hosts for Ubuntu 16.04"
echo "Enter domain name (byamungu.com or websitename.x):"
read DOMAIN_NAME
echo "Enter email address for webadmin (this will show app in std.404-page)"
read DOMAIN_ADMIN_EMAIL
echo "Do you want to disable the default page? (Y/N)"
read DESABLE_SITE

sudo mkdir -p /var/www/$DOMAIN_NAME/public_html
sudo chown -R $USER:$USER /var/www/$DOMAIN_NAME/public_html
sudo chmod -R 755 /var/www
sudo tee -a "/var/www/$DOMAIN_NAME/public_html/index.html" > /dev/null <<EOT
<html>
  <head>
    <title>Welcome to $DOMAIN_NAME!</title>
  </head>
  <body> <h1>Success!  The $DOMAIN_NAME virtual host is working!</h1>
  <p>Please consider making a small <a href="https://commerce.coinbase.com/checkout/b005ae5c-0509-491a-a84b-756057e43a0d">donation</a></p>
  </body>
</html>
EOT
sudo tee -a "/etc/apache2/sites-available/$DOMAIN_NAME.conf" > /dev/null <<EOT
<VirtualHost *:80>
        ServerAdmin $DOMAIN_ADMIN_EMAIL
        ServerName $DOMAIN_NAME
        ServerAlias www.$DOMAIN_NAME
        DocumentRoot /var/www/$DOMAIN_NAME/public_html

        <Directory /var/www/html/>
            Options Indexes FollowSymLinks
            AllowOverride All
            Require all granted
        </Directory>

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined

        <IfModule mod_dir.c>
            DirectoryIndex index.php index.pl index.cgi index.html index.xhtml index.htm
        </IfModule>

RewriteEngine on
RewriteCond %{SERVER_NAME} =$DOMAIN_NAME [OR]
RewriteCond %{SERVER_NAME} =www.$DOMAIN_NAME
RewriteRule ^ https://%{SERVER_NAME}%{REQUEST_URI} [END,NE,R=permanent]
</VirtualHost>
EOT

sudo a2ensite $DOMAIN_NAME.conf
if $DESABLE_SITE -eq "Y"
then
  sudo a2dissite 000-default.conf
fi
sudo service apache2 restart
echo "The web site $DOMAIN_NAME is now online!"
echo "Please restarte apache, use 'sudo service apache2 restart' or 'sudo systemctl restart apache2'"
