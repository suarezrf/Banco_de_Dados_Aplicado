-- 7D — Partition pruning
-- Execute:

-- EXPLAIN ANALYZE
-- em uma consulta que retorne somente pedidos de maio de 2026.

-- Mantenha o plano no arquivo.

-- Inclua um comentário SQL curto indicando qual partição foi utilizada.

explain analyze
select data_pedido from pedidos_historico_part where data_pedido >= '01-05-2026' and data_pedido < '01-06-2026'

--Seq Scan on pedidos_2026_s1 essa foi a partição que foi utilizada

-- "Seq Scan on pedidos_2026_s1 pedidos_historico_part  (cost=0.00..8.41 rows=49 width=8) (actual time=0.012..0.041 rows=49 loops=1)"
-- "  Filter: ((data_pedido >= '2026-01-05 00:00:00'::timestamp without time zone) AND (data_pedido < '2026-01-06 00:00:00'::timestamp without time zone))"
-- "  Rows Removed by Filter: 245"

-- "Planning Time: 0.101 ms"
-- "Execution Time: 0.053 ms"
