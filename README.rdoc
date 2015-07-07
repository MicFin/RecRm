## Set up Rails envirenment on AWS
This README file explains how to set up the AWS EC2 instance with Ubuntu, Apache, postgreSQL and Ruby on Rails

### GET STARTED

1. **Click the follwing link**, will take you to the AWS marketplace to begin setting up your EC2 instance
https://aws.amazon.com/marketplace/pp/B00JV8XNKQ/ref=gtw_msl_image?ie=UTF8&pf_rd_r=05ZA3J50A153TVH69TTW&pf_rd_m=A33KC2ESLMUT5Y&pf_rd_t=101&pf_rd_i=awsmp-gateway-1&pf_rd_p=1825567482&pf_rd_s=right-3

2. Assuming you have setup your aws account, **select your region** and **click continue**

3. Choose your Instance type and following directions to set up your key pair. When creating a key pair, .pem file will be downloaded.  Put this file in a safe place because you’ll need it to access SSH and FTP

4. Launch

 
### SSH

1. SSH username is Ubuntu

2. Get the public DNS. In the AWS EC2 console click on the instance, see below.
it looks like this: ec2-54-187-205-42.us-west-2.compute.amazonaws.com

3. Open Terminal and follow the steps below.  You'll need your private key you downloaded early.

```

 $ cd/dir/privatekeydir
 $ chmod 400 mykey.pem
 $ ssh -i private_key.pem ubuntu@ec2-public-dns-.us-west-2.compute.amazonaws.com

```

## INSTALL Ruby


### STEP 1: Get some dependencies 

```

$ sudo apt-get update
$ sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev 
$ sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties

```



### STEP 2: Install Ruby with RVM
```
sudo apt-get install libgdbm-dev libncurses5-dev automake libtool bison libffi-dev
curl -L https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm
echo "source ~/.rvm/scripts/rvm" >> ~/.bashrc
rvm install 2.1.2
rvm use 2.1.2 --default
ruby -v

```

### STEP 3: Tell Rubygems not to install the documentation for each package locally

```
echo "gem: --no-ri --no-rdoc" > ~/.gemrc

```


## INSTALL Rails

### STEP 1: Install Node.js

To install NodeJS, we're going to add it using a PPA repository:

```
sudo add-apt-repository ppa:chris-lea/node.js
sudo apt-get update
sudo apt-get install nodejs

```

### STEP 2: Now install Rails

`gem install rails`

run raisl -v to check everything is installed correctly

`rails -v`


## INSTALL PostgreSQL

### STEP 1: add a new repository and easily install

```
sudo sh -c "echo 'deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main' > /etc/apt/sources.list.d/pgdg.list"
wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get install postgresql-common
sudo apt-get install postgresql-9.3 libpq-dev

```

### STEP 2: Set up Postgres User

```
sudo -u postgres psql postgres

# \password postgres

Enter new password: 

```

## Create new rails app

```

rails new myapp -d postgresql
cd myapp
rake db:create
rails server


```

**You'll probably get this error in terminal**

` FATAL: Peer authentication failed for user "postgres" `

ou need to make a small shange to your pg_hba.conf locate /etc/posgresql/9.3/main/

```

$ cd /etc/postgresql/9.3/main
$ sudo pico ph_hba.conf

```

Details of the edit are here:
http://stackoverflow.com/questions/18664074/getting-error-peer-authentication-failed-for-user-postgres-when-trying-to-ge


## INSTALL APACHE

```

sudo apt-get update
sudo apt-get install apache2

```

More details: https://www.digitalocean.com/community/tutorials/how-to-configure-the-apache-web-server-on-an-ubuntu-or-debian-vps

## INSTALL PASSENGER
Passenger is going to help you launch your ruby app

```
sudo gem install passenger
sudo passenger-install-apache2-module

```

Following the instructions diring installing of passenger

```
- sudo pico apache2.conf
- cd sites-available
- sudo pico 000-default.conf
- Must restart server when changes are made to yml files


- add this line to apache conf
   LoadModule passenger_module /home/ubuntu/.rvm/gems/ruby-2.1.2/gems/passenger-4.0.45/buildout/apache2/mod_passenger.so
   <IfModule mod_passenger.c>
     PassengerRoot /home/ubuntu/.rvm/gems/ruby-2.1.2/gems/passenger-4.0.45
     PassengerDefaultRuby /home/ubuntu/.rvm/gems/ruby-2.1.2/wrappers/ruby
   </IfModule>


      <VirtualHost *:80>
      ServerName ec2-54-213-224-62.us-west-2.compute.amazonaws.com
      # !!! Be sure to point DocumentRoot to 'public'!
      DocumentRoot /etc/projects/myapp/public

        <Directory /etc/projects/myapp/public>
                #Options FollowSymLinks
                Options Indexes FollowSymLinks Includes ExecCGI
                AllowOverride All
                Order deny,allow
                Allow from all
        </Directory>
   </VirtualHost>

```



## Resources

- https://gorails.com/setup/ubuntu/13.10
- http://stackoverflow.com/questions/18664074/getting-error-peer-authentication-failed-for-user-postgres-when-trying-to-ge
- https://www.digitalocean.com/community/tutorials/how-to-configure-the-apache-web-server-on-an-ubuntu-or-debian-vps
- http://nathanhoad.net/how-to-ruby-on-rails-ubuntu-apache-with-passenger
- http://serverfault.com/questions/110154/whats-the-default-superuser-username-password-for-postgres-after-a-new-install
- http://stackoverflow.com/questions/2786344/server-unable-to-find-public-folder-in-rails-3-production-environment

