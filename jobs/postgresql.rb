require 'pg'


#load('config_postgresql.rb')

pg = eval(File.open(File.expand_path('config_postgresql.rb')).read)

begin 

  db = PGconn.connect( pg['host'], pg['port'], pg['options'], pg['tty'],pg['dbname'], pg['user'], pg['password'])

  current_hitratio = 0

  SCHEDULER.every pg['freq'] do

    #keep previous values	
    last_valuation = current_valuation
    last_karma     = current_karma


    res = db.exec("select count(*) from pg_stat_activity;")
    current_valuation = res.getvalue(0,0)

    res = db.exec("select  (sum(heap_blks_hit) - sum(heap_blks_read)) / sum(heap_blks_hit) as ratio 
	from pg_statio_user_tables;")
    current_hitratio = 	 res.getvalue(0,0)


    send_event('valuation', { current: current_valuation, last: last_valuation })
    send_event('hitratio', { value: current_hitratio })
  end

rescue PGError
 puts "\e[33mFor the PostgreSQL widget to work, you set up config_postgresql.rb file.\e[0m"
end

db.close()
