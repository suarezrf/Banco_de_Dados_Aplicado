
select p.id as pedido_id, c.nome as cliente, r.nome as restaurante,pr.nome as produto, ip.quantidade, ip.preco_unitario, ip.quantidade * ip.preco_unitario as subtotal
from pedidos p
join clientes c
    on c.id = p.cliente_id
join restaurantes r
    on r.id = p.restaurante_id
join itens_pedido ip
    on ip.pedido_id = p.id
join produtos pr
    on pr.id = ip.produto_id
where p.status = 'ENTREGUE';

