
# PostgreSQL Dashboard


## Install 


### Prepare the environement

``
  sudo apt-get update 	
  sudo apt-get install ruby rubygems ruby-dev bundler
  sudo apt-get install postgresql-server-dev-9.4
``

(replace `9.4` by your current postgreSQL version)


### Install Dashing

``
  sudo gem install dashing
``


### Install PostgreSQL Dashboard

``
  wget pgdashboard.zip
  unzip pgdashboard.zip
  cd pgdashboard
  bundle
``

### Launch

``
  dashing start	
``

## Links

  * Check out http://shopify.github.com/dashing for more information.
