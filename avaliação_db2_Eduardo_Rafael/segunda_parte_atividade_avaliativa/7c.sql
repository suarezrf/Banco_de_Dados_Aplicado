- Popule a tabela particionada utilizando os pedidos existentes.

-- Calcule:

-- valor_total =
-- soma dos itens
-- + taxa de entrega
-- - desconto

insert into pedidos_historico_part (
    pedido_id,
    cliente_id,
    restaurante_id,
    data_pedido,
    status,
    canal,
    valor_total
)
select p.id as numero_pedido,
	p.cliente_id,
	p.restaurante_id,
	p.data_pedido,
	p.status,
	p.canal,
	sum(i.quantidade * i.preco_unitario)
		+ p.taxa_entrega
		- p.desconto as valor_total
from pedidos p
inner join itens_pedido i
	on i.pedido_id = p.id
group by 
    p.id,
    p.cliente_id,
    p.restaurante_id,
    p.data_pedido,
    p.status,
    p.canal,
    p.taxa_entrega,
    p.desconto
	
order by valor_total desc ;

