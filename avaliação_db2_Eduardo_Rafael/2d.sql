with gastos as (
    select c.id, .nome,
           sum(
               ip.quantidade * ip.preco_unitario
               + p.taxa_entrega
               - p.desconto
           ) as total_gasto
    from clientes c
    join pedidos p
        on p.cliente_id = c.id
    join itens_pedido ip
        on ip.pedido_id = p.id
    where p.status in ('PREPARANDO', 'SAIU_ENTREGA', 'ENTREGUE')
    group by c.id, c.nome
)
select *
from gastos
order by total_gasto desc
limit 15;
