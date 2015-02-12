
# Install PostgreSQL Dashboard


## Prepare the environement

```
  sudo apt-get update 	
  sudo apt-get install ruby rubygems ruby-dev bundler
  sudo apt-get install postgresql-server-dev-9.4
```

(replace `9.4` by your current postgreSQL version)


## Install Dashing

```
  sudo gem install dashing
```


## Install PostgreSQL Dashboard

```
  wget https://github.com/daamien/pgDashboard/archive/master.zip
  unzip master.zip
  cd pgDashboard-master
  bundle
```

## Edit the config file

```
  vi config_postgresql.rb
```

## Launch

```
  dashing start	
```

