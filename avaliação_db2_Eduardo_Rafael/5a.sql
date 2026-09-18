

explain analyze
select *
from pedidos
where status = 'ENTREGUE'
  and data_pedido >= timestamp '2026-05-01 00:00:00'
  and data_pedido < timestamp '2026-06-01 00:00:00';
-- índice criado para a consulta

create index idx_pedidos_status_data
on pedidos (status, data_pedido);

analyze pedidos;
-- segunda execução

explain analyze
select *
from pedidos
where status = 'ENTREGUE'
  and data_pedido >= timestamp '2026-05-01 00:00:00'
  and data_pedido < timestamp '2026-06-01 00:00:00';

-- comentário:
-- o índice foi criado usando status e data_pedido
-- isso pode diminuir a quantidade de registros que são examinados
