SELECT 
  count(*) 
FROM 
  pg_stat_activity 
WHERE 
  current_query != '<IDLE>'
;
