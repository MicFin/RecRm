## Set up Rails envirenment on AWS
This README file explains how to set up the AWS EC2 instance with Ubuntu, Apache, postgreSQL and Ruby on Rails

### Get Started

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

4. `$ cd/dir/privatekeydir`

5. `$ chmod 400 mykey.pem`

6. `$ ssh -i private_key.pem ubuntu@ec2-public-dns-.us-west-2.compute.amazonaws.com`


## Install Ruby


### STEP 1: Get some dependencies 
1. ```
sudo apt-get update
sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties
```



### STEP 2: UPDATE RVM, RUBY, RAILS
1. enter rubyconsole
2. `$ rvm get stable`
3. `$ rvm reload`
4. `$ rvm list known`
5. `$ rvm install 2.1`
6. `$ rvm --default use ruby-2.1.2`
7. `$ gem install rails`
8. `$ gem update --system`

### STEP 3: CREATE NEW RUBY APPLICATION
1. '$ cd stack/projects'
2. '$ mkdir myTestApp'
3. '$ cd myTestApp'
4. '$ rvm use ruby-2.1.2@myapp --ruby-version --create'
5. '$ rails new . -d postgresql'  //The . tells rails use the latest version in the current directory

### STEP 4: LAUCH SAMPLE APP
1. Launch ruby console (See STEP: 1)
2. `$ cd myTestApp`
3. `$ rails server`
4. In your browser add :3000 next to your public DNS or Elastic IP/Domain name, example: 54.187.9.96:3000


### STEP 5: SETUP VIRTUALHOST BEFORE YOU CAN PUBLISH YOUR APP
 
1. EDIT httpd.conf 

  `$ cd stack/apache2/conf/`

  `pico httpd.conf`

  Replace the following code:
  
  ```
  <Directory />
    AllowOverride none
    Require all denied
  </Directory>
  ```
  With this code:
  
  ```
  <Directory />
    Order deny,allow
    Deny from all
    Options None
    AllowOverride None
  </Directory>
  ```
  
2. EDIT httpd-vhosts.conf

  `$ cd stack/apache2/conf/extra`

  `pico httpd-vhosts.conf`
  
  Add project as a Virtual Host
  
  ```
  NameVirtualHost *:80
  
  <VirtualHost *:80>
    ServerAdmin bitnami@54.187.9.96
    DocumentRoot "/opt/bitnami/projects/myProject" #same as stack/projects/myProject/public
    <Directory />
      #Options FollowSymLinks
      Options Indexes FollowSymLinks Includes ExecCGI
      AllowOverride All
      Order deny,allow
      Allow from all
    </Directory>
    ServerName 54.187.9.96
    ServerAlias 54.187.9.96
    ErrorLog "logs/54.187.9.96-error_log"
    CustomLog "logs/54.187.9.96-access_log" common
  </VirtualHost>
  ```

### STEP 6: CONNECT TO GIT REPOSITORY
1. create new repo on GitHub.com
2. SSH into server
3. cd /project/directory
4. git init 
5. it remote add origin http://IP/path/to/repository
6. git add -A 
7. git commit -m 'comment'
8. git push origin master





