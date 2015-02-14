
# PostgreSQL Dashboard

PostgreSQL Dashboard is simple monitoring tool that gives a live overview of a PostgreSQL instance.


It is designed to be displayed on a large screen in a monitoring room or an open space office.
The current dashboard is currently composed of 5 widgets :

* **General Info** : version, number of host databases 
* **Hit Ratio** : the % of data found in cache
* **Buffers** : The number of new buffers allocated
* **Queries** : The number of active queries currently running of the instance
* **Twitter** : A glimpse of the #PostgreSQL feed

Adding a new job should be fairly easy and writing a custom widget to display stats you find relevant or some "business logic" valuation.

The layout is entirely flexible. You can easily drag'n'drop any widget to put wherever you want on the screen. You can also edit the dashboard HTML code to adapt it to wide screens.

## Quick Start

If you already have installed a Ruby environnement, simply type:

```
  git clone https://github.com/daamien/pgDashboard.git && cd pgDashboard
  bundle
  mv config_postgresql.rb.example config_postgresql.rb && vi config_postgresql.rb
  dashing start
```

Now go to [http://localhost:3030]() and have fun!

For more instructions, please read [INSTALL.md](https://github.com/daamien/pgDashboard/blob/master/INSTALL.md)

## Requirements

PostgreSQL Dashboard is based on Dashing, a very nice dashboard framework.
Dashing itself is based on Sinatra, a very nice Ruby web framework.

Basically to run this tool, you will need:
 
* PostgreSQL 9.0.x or later
* Ruby 1.9.x or later
* Sinatara 1.4.x or later
* Dashing 1.3.x or later

## Security

/!\ WARNING /!\

__You need to be careful about the security of your PostgreSQL server when installing this tool .__

If you don't protect your communications, an attacker placed between the dashboard and PostgreSQL could gain access to your database server.

Therefore I **strongly** recommend the following precautions :

* [Read the Great PostgreSQL Documentation](http://www.postgresql.org/docs/current/static/auth-pg-hba-conf.html)
* Check your ``pg_hba.conf`` file
* Do not allow users to access PostgreSQL Dashboard from the Internet
* Do not use a superuser in the config_postgresql.rb file


## License 

PostgreSQL Dashboard is distributed under the PostgreSQL License.

Dashing is distributed under the MIT License.

The name "PostgreSQL" is registered trademark and the PostgreSQL Logo is a copyrighted design of the PostgreSQL Global Development Group.

## Links

  * Check out the [Dashing documentation](http://shopify.github.com/dashing) for more information.
