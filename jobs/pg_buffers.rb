###
### pg_buffers job
### display the number of new buffers allocated
###
### Widget :
### <div data-id="buffers" data-view="Graph" data-title="Buffers" data-moreinfo="New buffers allocated"></div> 

#
# SET A CUSTOM FREQUENCY
#
freq = '5s'


require 'pg'

begin

  # Read the config file
  pg = eval(File.open(File.expand_path('config_postgresql.rb')).read)

  # if freq is not defined use the default
  freq = pg['freq'] if freq.nil?
  
  # Connect
  db = PGconn.connect( pg['host'], pg['port'], pg['options'], pg['tty'],pg['dbname'], pg['user'], pg['password'])
  version = db.parameter_status('server_version');
  major_version = version.split(".").take(2).join(".").sub(/beta.*/,'').sub(/rc.*/,'')

  # Load the SQL query
  path='lib/postgresql/sql/'+ major_version +'/buffers.sql'
  sql = File.read(path)

  # Init vars
  points = []
  (1..12).each do |i|
    points << { x: i, y: 0 }
  end
  last_x = points.last[:x]
  current_buffers_alloc = 0
  last_buffers_alloc = 0

  # First run
  res = db.exec(sql)
  current_buffers_alloc = res.getvalue(0,0).to_i


  # Loop !
  SCHEDULER.every freq do

   # Save previous value 
   last_buffers_alloc = current_buffers_alloc

   # Collect
   res = db.exec(sql)
   current_buffers_alloc = res.getvalue(0,0).to_i 	
   delta = current_buffers_alloc - last_buffers_alloc
   points.shift
   last_x += 1
   points << { x: last_x, y: delta }

   # send
   send_event('buffers', points: points)
  
  end

rescue PGError
 puts "\e[33mConnection Error : please check the config_postgresql.rb file.\e[0m"
end

