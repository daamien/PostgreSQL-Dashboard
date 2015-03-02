
# Install PostgreSQL Dashboard


## Prepare the environment

You need to setup a Ruby environment and the PostgreSQL development package.

For instance on debian/ubuntu, here's the typical command lines you have to run:

```
  sudo apt-get update 	
  sudo apt-get install nodejs ruby rubygems ruby-dev bundler
  sudo apt-get install postgresql-server-dev-9.4
```

Of you need to replace `9.4` by your current postgreSQL version.

On some linux distributions, installing ``nodejs`` can be tricky. If you're having problems, this page might help: https://github.com/joyent/node/wiki/Installing-Node.js-via-package-manager 

## Install PostgreSQL Dashboard

```
  wget https://github.com/daamien/PostgreSQL-Dashboard/archive/master.zip
  unzip master.zip
  cd PostgreSQL-Dashboard-master
  bundle
```

## Edit the config file

```
  cp config_postgresql.rb.example config_postgresql.rb
  vi config_postgresql.rb
```

**Do not use a superuser account to connect to Postgres**

## Launch

```
  dashing start	
```

The dashboard will be available the 3030 port of the server.

For instance [http://yourserver:3030]()

## Security

By default there's no authentification. Anyone can access the dashboard. If you need to implement authentication, please read [How to: Add authentication](https://github.com/Shopify/dashing/wiki/How-to:-Add-authentication)

