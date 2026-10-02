
-- Questão 9 — Functions
-- Crie a function valor_pedido(p_pedido_id INTEGER), que retorna a soma de quantidade *
-- preco_unitario dos itens do pedido, ou 0 se o pedido não tiver itens. Use-a em uma consulta
-- que liste pedido_id, data_pedido, status e o valor de cada pedido do cliente 1234 em 2024.


create or replace function valor_pedido(p_pedido_id integer)
returns numeric as $$
    select coalesce(sum(quantidade * preco_unitario), 0)
    from item_pedido
    where pedido_id = p_pedido_id;
$$ language sql;

select pedido_id, data_pedido, status, valor_pedido(pedido_id) as valor
from pedido
where cliente_id = 1234
  and extract(year from data_pedido) = 2024
order by data_pedido;

-- Foi bom até que durou (isso não uma prova foi uma covardia contra  os estudantes | Foi igualzinho a lutar contra o Mike Tyson no auge ;-; )
