SymfonyDevEnv
=============

A simple script and procedure to create a basic Symfony development environment in Ubuntu.

## Instructions ##
### 1. Preparations ###
While this script takes care of most of the installation procedure, you still need to type some commands manually to get it started.

Install git and prepare the installation directory:
	sudo apt-get install git
	sudo mkdir /var/www
	sudo chmod 777 -R /var/www
	cd /var/www

Now pull the most recent version of the installation script:
	git clone https://github.com/mundofr/SymfonyDevEnv .

And set it as executable
	chmod +x install.sh

### 2. Execute the script ###
To run the script, enter:
	./install.sh

The installation should only ask for your root password once to download packages (via `apt-get`) and perform some slight changes to your system configuration (modify `/etc/hosts`).

### 3. Verify installation ###
In your browser, go to [http://dev.com/config.php](http://dev.com/config.php) and you should see a Symfony status page. That page will list any misconfigurations in your system, and it'll likely throw an error on the `date.timezone` configuration in `php.ini`. To fix it you have the modify the `php.ini` file that is shown on that page (on most system configurations the file will be `/etc/php5/apache2/php.ini`)

- From your terminal enter `sudo nano /etc/php5/apache2/php.ini`
- Press `Ctrl`+`W`, type `date.timezone` and press enter.
- Replace `;date.timezone` with `date.timezone = UTC` (or any other from [This list of supported timezones](http://www.php.net/manual/en/timezones.php).
- Press `Ctrl`+`X`, type 'y', then press enter.
- Finally, restart the apache server by typing `sudo server apache2 restart`

Revisit the `config.php` page, and you should see a green banner stating that the system is ready for the final configurations!

### 4. Final configurations ###
Click the link *"Configure your Symfony Application online"* to set up the database. Most of the configuration parameters can be left as they are; however, there are two parameters that should be taken care of:

* Name: (anything in case you want a custom database name)
* Password: enter `devroot` since that's how the MySQL server was automatically configured

Finally, you will be taken to a Welcome Page, from there you are good to go!

## Default values ##
The script configures some default values for your convenience, and those are:
- **MySQL:** username `root`, password `devroot`
- **Domain name:** `dev.com` (and `www.dev.com` will redirect to `dev.com`)
- **WebRoot Directory:**: `/var/www/dev.com/`


## Testing ##
The script was developed and tested (so far) only in Ubuntu 13.10 (desktop-amd64), but it was adapted from a production script that is currently used in Ubuntu Server 12.04 LTS instances.
