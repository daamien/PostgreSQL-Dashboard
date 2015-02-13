SELECT 
  count(query) 
FROM 
  pg_stat_activity 
WHERE 
  state = 'active'
;
