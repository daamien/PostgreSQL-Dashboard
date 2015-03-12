SELECT count(datname) as databases, 
                          substring(version() from E'\d+.\d+.\d+') as version ,
                          pg_size_pretty(sum(pg_database_size(datname))::bigint) as total_size,
                          to_char(now(),'HH24:MI') as time
                   FROM pg_database
                   WHERE datistemplate = 'f';
