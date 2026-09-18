create or replace view vw_painel_pedidos as
select p.id as pedido_id, p.data_pedido, c.nome as cliente,c.cidade as cidade_cliente, r.nome as restaurante, p.status, p.canal, e.nome as entregador,
       coalesce(sum(ip.quantidade), 0) as quantidade_itens,
       coalesce(sum(ip.quantidade * ip.preco_unitario), 0) as valor_itens,p.taxa_entrega, p.desconto,
       coalesce(sum(ip.quantidade * ip.preco_unitario), 0)
           + p.taxa_entrega
           - p.desconto as valor_final
from pedidos p
join clientes c
    on c.id = p.cliente_id
join restaurantes r
    on r.id = p.cliente_id
left join entregadores e
    on e.id = p.entregador_id
left join itens_pedido ip
    on ip.pedido_id = p.id
group by p.id, p.data_pedido, c.nome,c.cidade, r.nome, p.status, p.canal, e.nome,p.taxa_entrega,p.desconto;
