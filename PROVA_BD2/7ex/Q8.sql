-- questão 8 — Índices e EXPLAIN
-- a) Rode EXPLAIN (ANALYZE, BUFFERS) para SELECT * FROM pedido WHERE cliente_id = 1234 AND status = 'PAGO'.

-- b) Crie o índice composto adequado para essa consulta, atualize as estatísticas da tabela e rode o mesmo EXPLAIN.

-- c) Escreva duas consultas com EXPLAIN que demonstrem a regra do prefixo: uma que filtra só por uma coluna e usa o
-- índice criado, outra que filtra só pela outra coluna e não o usa.
--


explain (analyze, buffers)
select * from pedido where cliente_id = 1234 and status = 'PAGO';

create index idx_pedido_cliente_status on pedido (cliente_id, status);

analyze pedido;

explain (analyze, buffers)
select * 
from pedido 
where cliente_id = 1234 and status = 'PAGO';

explain
select * 
from pedido 
where cliente_id = 1234;

explain
select * 
from pedido
where status = 'PAGO';
