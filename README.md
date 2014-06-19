## NEW RAILS APP
This README file explains how to set up your ruby on rails envirenment, create new rails apps and how to launch and publish it. 

### STEP 1: LAUNCH RUBY CONSOLE
1. ssh into instance: https://github.com/kindrdfood/RecRm/blob/master/aws/README.md
2. `$ cd stack`
3. '$ sudo ./rubyconsole'



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





