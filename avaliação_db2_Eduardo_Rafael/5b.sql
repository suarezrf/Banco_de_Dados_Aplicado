
explain analyze
select p.id, p.status,ip.produto_id, ip.quantidade, ip.preco_unitario
from pedidos p
join itens_pedido ip
    on ip.pedido_id = p.id
where p.id = 100;
create index idx_itens_pedido_pedido_id
on itens_pedido (pedido_id);
analyze itens_pedido;
explain analyze
select p.id, p.status, ip.produto_id,ip.quantidade, ip.preco_unitario
from pedidos p
join itens_pedido ip
    on ip.pedido_id = p.id
where p.id = 100;
