--  5B — Itens de um pedido
-- Execute uma consulta que faça JOIN entre:

-- pedidos
-- itens_pedido
-- e filtre um único pedido pelo seu ID.

-- Analise com:

-- EXPLAIN ANALYZE
-- Depois:

-- verifique qual coluna da tabela itens_pedido participa do relacionamento;
-- crie um índice adequado;
-- execute novamente o plano;
-- mantenha a comparação no arquivo.

explain analyze 
select p.id as PEDIDOS_ID, i.id AS ITENS_ID
from pedidos p 
inner join itens_pedido i
	on i.pedido_id = p.id
create index id_PEDIDOS_itens on itens_pedido(pedido_id)

-- "Hash Join  (cost=1024.00..2522.90 rows=75000 width=16) (actual time=18.931..55.223 rows=75000 loops=1)"
-- "  Hash Cond: (i.pedido_id = p.id)"
-- "  ->  Seq Scan on itens_pedido i  (cost=0.00..1302.00 rows=75000 width=16) (actual time=0.010..7.807 rows=75000 loops=1)"
-- "  ->  Hash  (cost=649.00..649.00 rows=30000 width=8) (actual time=18.842..18.845 rows=30000 loops=1)"
-- "        Buckets: 32768  Batches: 1  Memory Usage: 1428kB"
-- "        ->  Seq Scan on pedidos p  (cost=0.00..649.00 rows=30000 width=8) (actual time=0.011..8.710 rows=30000 loops=1)"
-- "Planning Time: 0.366 ms"
-- "Execution Time: 59.446 ms"
--------------------------------------------------------------------
-- "Hash Join  (cost=1024.00..2522.90 rows=75000 width=16) (actual time=13.461..46.246 rows=75000 loops=1)"
-- "  Hash Cond: (i.pedido_id = p.id)"
-- "  ->  Seq Scan on itens_pedido i  (cost=0.00..1302.00 rows=75000 width=16) (actual time=0.010..7.152 rows=75000 loops=1)"
-- "  ->  Hash  (cost=649.00..649.00 rows=30000 width=8) (actual time=13.382..13.386 rows=30000 loops=1)"
-- "        Buckets: 32768  Batches: 1  Memory Usage: 1428kB"
-- "        ->  Seq Scan on pedidos p  (cost=0.00..649.00 rows=30000 width=8) (actual time=0.013..6.205 rows=30000 loops=1)"
-- "Planning Time: 0.352 ms"
-- "Execution Time: 50.234 ms":

-- senti a aura aqui do lobby pia 
