###
### pg_buffers job
### display the number of new buffers allocated
###
### Widget :
### <div data-id="queries" data-view="Number" data-title="Queries" data-moreinfo="active backends" data-prefix=""></div>

#
# SET A CUSTOM FREQUENCY
#
freq = '5s'


require 'pg'

begin
  # Read the config file
  pg = eval(File.open(File.expand_path('config_postgresql.rb')).read)

  # If freq is not defined use the default
  freq = pg['freq'] if freq.nil?

  # Connect
  db = PGconn.connect( pg['host'], pg['port'], pg['options'], pg['tty'],pg['dbname'], pg['user'], pg['password'])
  version = db.parameter_status('server_version');
  major_version = version.split(".").take(2).join(".").sub(/beta?/,'').sub(/rc?/,'')


  # Load the SQL query
  path='lib/postgresql/sql/'+ major_version +'/queries.sql'
  sql = File.read(path)

  # Init vars
  current_queries=0

  # Loop !
  SCHEDULER.every freq do

    # Collect
    res = db.exec(sql)
    last_queries = current_queries
    current_queries = res.getvalue(0,0).to_i

    # Send
    send_event('queries', { current: current_queries, last: last_queries })
  end

rescue PGError
 puts "\e[33mConnection Error : please check the config_postgresql.rb file.\e[0m"
end

