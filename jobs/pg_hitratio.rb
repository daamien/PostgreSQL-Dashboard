###
### pg_hitratio job
### returns the % of data found in cache 
###
### Widget :
###  <div data-id="hitratio" data-view="Meter" data-title="Hit Ratio" data-min="0" data-max="100" data-moreinfo="data found in cache"></div>


#
# SET A CUSTOM FREQUENCY
#
#freq = '5s'


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
  path='lib/postgresql/sql/'+ major_version +'/hit_ratio.sql'
  sql = File.read(path)

  # Init vars
  current_hitratio = 0

  # Loop !
  SCHEDULER.every freq do

    # hit ratio
    res = db.exec(sql)
    current_hitratio = 	res.getvalue(0,0).to_i


    # send
    send_event('hitratio', { value: current_hitratio })
  end

rescue PGError
 puts "\e[33mConnection Error : please check the config_postgresql.rb file.\e[0m"
end

