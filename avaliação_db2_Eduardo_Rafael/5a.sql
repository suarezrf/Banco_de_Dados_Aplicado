
explain analyze
select *
from pedidos
where status = 'ENTREGUE'
  and data_pedido >= timestamp '2026-05-01 00:00:00'
  and data_pedido < timestamp '2026-06-01 00:00:00';
