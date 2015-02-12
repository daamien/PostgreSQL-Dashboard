SELECT  
  CASE sum(heap_blks_hit) 
  WHEN 0 THEN NULL 
  ELSE trunc((sum(heap_blks_hit) - sum(heap_blks_read)) / sum(heap_blks_hit)*100) 
  END 
FROM
  pg_statio_user_tables
;
