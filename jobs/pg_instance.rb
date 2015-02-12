###
### pg_instance job
### display general info about the PostgreSQL instance
###
### Widget :

#
# SET A CUSTOM FREQUENCY
#
freq = '1m'

require 'pg'

begin

  # Read the config file
  pg = eval(File.open(File.expand_path('config_postgresql.rb')).read)

  # if freq is not defined use the default
  freq = pg['freq'] if freq.nil?

  # Connect
  db = PGconn.connect( pg['host'], pg['port'], pg['options'], pg['tty'],pg['dbname'], pg['user'], pg['password'])
  version = db.parameter_status('server_version');
  major_version = version.split(".").take(2).join(".")	

  # Load the SQL query
  path='lib/postgresql/sql/'+ major_version +'/instance.sql'
  sql = File.read(path)


  # Loop !
  SCHEDULER.every pg['freq'] do

    # Collect and Prepare	
    res = db.exec(sql);
    instance = []  # rebuild the list every time
    instance << { label: 'Host', value: pg['host'] }
    instance << { label: 'Version', value: version }
    instance << { label: 'Databases', value: res[0]['databases'] }	
    instance << { label: 'Total Size', value: res[0]['total_size'] }
    instance << { label: 'Time' , value: res[0]['time'] }	


    # send
    send_event('instance', { items: instance })	
  end

rescue PGError
 puts "\e[33mConnection Error : please check the config_postgresql.rb file.\e[0m"
end

