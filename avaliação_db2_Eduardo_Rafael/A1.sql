
select id,data_pedido, status, canal,taxa_entrega,desconto
from pedidos
where canal = 'APP'
  and data_pedido >= timestamp '2026-01-01 00:00:00'
  and data_pedido < timestamp '2027-01-01 00:00:00'
  and status in ('PREPARANDO', 'SAIU_ENTREGA')
order by data_pedido asc;
