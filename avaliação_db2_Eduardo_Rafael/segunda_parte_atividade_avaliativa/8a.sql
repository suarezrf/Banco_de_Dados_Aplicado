-- Crie uma function chamada:

-- fn_total_pedido
-- Ela deverá:

-- receber o ID do pedido;
-- calcular a soma dos itens;
-- adicionar a taxa de entrega;
-- subtrair o desconto;
-- retornar o total como NUMERIC.
-- Depois teste a function em pelo menos um pedido.

create or replace function fn_total_pedido(p_id bigint)
returns numeric
language plpgsql
as $$
declare 
	v_total numeric;

begin 


	select
		coalesce(sum(i.quantidade * i.preco_unitario), 0)
		+ p.taxa_entrega
		- p.desconto
	into v_total
	from pedidos p 
	inner join itens_pedido i
		on i.pedido_id = p.id
	where p.id = p_id
	group by 
		p.id,
		p.taxa_pedido,
		p.desconto;
	return v_total;
end;
$$
