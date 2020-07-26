# Configurations files for WP

## 1. Create database

```
# root is the user name, -p will promt and ask for a password
mysql -u root -p

# Create database
CREATE DATABASE <database_name> DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

# Add a new user
GRANT ALL ON <database_name>.* TO '<database_username>'@'localhost' IDENTIFIED BY '<database_password>';

# Flush privileges so that the current instance of MySQL knows about the changes
FLUSH PRIVILEGES;

# Exit out of MYSQL
EXIT;


```

## 2. Set up wordpress

### Download wordpress and set permissions

```
# Change into a writable directory
cd /tmp

# Download the compressed release by typing:
curl -O https://wordpress.org/latest.tar.gz

# Extract the compressed file to create the WordPress directory
tar xzvf latest.tar.gz

```

I save all my webiste in the `/var/www/<domain_name>/public_html`

```
# Copy the entire contents of the directory into our document root.
sudo cp -a /tmp/wordpress/. /var/www/<domain_name>/public_html
```

We’ll start by giving ownership of all the files to the `www-data` user and group

```
# Update the ownership:
sudo chown -R www-data:www-data /var/www/<domain_name>/public_html


# Set the correct permissions on the WordPress directories and files
sudo find /var/www/<domain_name>/public_html/ -type d -exec chmod 750 {} \;
sudo find /var/www/<domain_name>/public_html/ -type f -exec chmod 640 {} \;

```

### Setting up the WordPress Configuration File

```
# To grab secure values from the WordPress secret key generator
curl -s https://api.wordpress.org/secret-key/1.1/salt/

```

copy the values from above

```
# Open then the WordPress configuration file
sudo nano /var/www/<domain_name>/public_html/wp-config.php
```

```
define('AUTH_KEY',         '<put your unique phrase here>');
define('SECURE_AUTH_KEY',  '<put your unique phrase here>');
define('LOGGED_IN_KEY',    '<put your unique phrase here>');
define('NONCE_KEY',        '<put your unique phrase here>');
define('AUTH_SALT',        '<put your unique phrase here>');
define('SECURE_AUTH_SALT', '<put your unique phrase here>');
define('LOGGED_IN_SALT',   '<put your unique phrase here>');
define('NONCE_SALT',       '<put your unique phrase here>');
```

Configure database connection

```

define('DB_NAME', '<database_name>');

/** MySQL database username */
define('DB_USER', '<database_username>');

/** MySQL database password */
define('DB_PASSWORD', '<database_password>');

. . .

define('FS_METHOD', 'direct');

```
