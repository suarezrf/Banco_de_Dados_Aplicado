--Demanda 5 — Lentidão no sistema
--15 pontos

--O time de backend informou que algumas consultas começaram a ficar lentas.

--Você foi chamado para investigar.

--5A — Busca por período e status
--Execute:

--EXPLAIN ANALYZE
--SELECT *
--FROM pedidos
--WHERE status = 'ENTREGUE'
  --AND data_pedido >= TIMESTAMP '2026-05-01 00:00:00'
  --AND data_pedido <  TIMESTAMP '2026-06-01 00:00:00';
--Depois:

--crie um índice que faça sentido para esse padrão de consulta;
--execute ANALYZE;
--execute novamente o mesmo EXPLAIN ANALYZE.
--Mantenha no arquivo os dois planos.

--Inclua um comentário SQL de até 4 linhas explicando o que mudou.

EXPLAIN ANALYZE
SELECT *
FROM pedidos
WHERE status = 'ENTREGUE'
  AND data_pedido >= TIMESTAMP '2026-05-01 00:00:00'
  AND data_pedido <  TIMESTAMP '2026-06-01 00:00:00';
  
-- --"Seq Scan on pedidos  (cost=0.00..874.00 rows=303 width=90) (actual time=0.124..4.304 rows=294 loops=1)"
-- "  Filter: ((data_pedido >= '2026-05-01 00:00:00'::timestamp without time zone) AND (data_pedido < '2026-06-01 00:00:00'::timestamp without time zone) AND ((status)::text = 'ENTREGUE'::text))"
-- "  Rows Removed by Filter: 29706"
-- "Planning Time: 0.250 ms"
-- "Execution Time: 4.354 ms"

create index padrao_consulta on pedidos(status)

-- "Bitmap Heap Scan on pedidos  (cost=69.36..523.36 rows=303 width=90) (actual time=0.446..2.868 rows=294 loops=1)"
-- "  Recheck Cond: ((status)::text = 'ENTREGUE'::text)"
-- "  Filter: ((data_pedido >= '2026-05-01 00:00:00'::timestamp without time zone) AND (data_pedido < '2026-06-01 00:00:00'::timestamp without time zone))"
-- "  Rows Removed by Filter: 5706"
-- "  Heap Blocks: exact=349"
-- "  ->  Bitmap Index Scan on padrao_consulta  (cost=0.00..69.29 rows=6000 width=0) (actual time=0.335..0.336 rows=6000 loops=1)"
-- "        Index Cond: ((status)::text = 'ENTREGUE'::text)"
-- "Planning Time: 0.453 ms"
-- "Execution Time: 2.931 ms"


-=-=-=- resposta =-=-=-=-=-
 -- na primeira query o tempo de execução era de "Execution Time: 4.354 ms" na segunda o tempo foi de "Execution Time: 2.931 ms"
 -- tambem foi adicionado novas informações como  ->  Bitmap Index Scan on padrao_consulta  (cost=0.00..69.29 rows=6000 width=0) (actual time=0.335..0.336 rows=6000 loops=1)"
 --"        Index Cond: ((status)::text = 'ENTREGUE'::text)"
