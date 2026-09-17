select *
from vw_painel_pedidos
where status = 'ENTREGUE'
order by valor_final desc
limit 20;

