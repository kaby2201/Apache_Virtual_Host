# Apache Virtual Host
### DNS settings
Start by pointing your type A domain to the servers public IP.
### Clone this repo
To start using the scripts;
1. Clone the project: ``git clone https://github.com/kaby2201/scripts.git``
2. Allow access to execute script `` chmod 775 scripts/<filename>.sh``
3. Execute the script `` scripts/<filename>.sh ``

## SSL - Let’s Encrypt to obtain an SSL certificate
### Step 1 — Installing Certbot
The first step to using Let’s Encrypt to obtain an SSL certificate is to install the Certbot software on your server.

Certbot is in very active development, so the Certbot packages provided by Ubuntu tend to be outdated. However, the Certbot developers maintain a Ubuntu software repository with up-to-date versions, so we’ll use that repository instead.

First, add the repository:

`` sudo add-apt-repository ppa:certbot/certbot ``
You’ll need to press ENTER to accept.

Install Certbot’s Apache package with apt:
`` sudo apt install python-certbot-apache ``

### Step 2 - Set Up the SSL Certificate
Run the newhttpsdomain.sh file
`` sudo apache2ctl configtest ``
If you get an error, reopen the virtual host file and check for any typos or missing characters. Once your configuration file’s syntax is correct, reload Apache to load the new configuration

`` sudo systemctl reload apache2 ``

### Step 4 — Obtaining an SSL Certificate
Certbot provides a variety of ways to obtain SSL certificates through plugins. The Apache plugin will take care of reconfiguring Apache and reloading the config whenever necessary. To use this plugin, type the following:

``sudo certbot --apache -d your_domain -d www.your_domain ``

### Step 5 — Verifying Certbot Auto-Renewal
Let’s Encrypt’s certificates are only valid for ninety days. This is to encourage users to automate their certificate renewal process. The certbot package we installed takes care of this for us by adding a renew script to /etc/cron.d. This script runs twice a day and will automatically renew any certificate that’s within thirty days of expiration.

To test the renewal process, you can do a dry run with certbot:

`` sudo certbot renew --dry-run ``
