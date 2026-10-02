-- Questão 1 — Venda em uma transação com SAVEPOINT
-- A cliente 3 compra 2 unidades do produto 2 e 1 unidade do produto 5. A loja quer incluir também, 
-- como brinde, 1 unidade do produto 7. Se o brinde falhar, a venda deve seguir sem ele. Escreva um único script que:

-- abra uma transação explícita e insira o pedido com status PENDENTE;
-- insira os itens com preco_unitario igual ao preço atual do produto, lido da tabela produto, sem digitar o valor;
-- baixe o estoque com escrita atômica, sem ler o estoque em um SELECT separado;
-- crie um SAVEPOINT antes do brinde, tente inserir o item e baixar o estoque, e desfaça só o brinde quando o erro ocorrer;
-- confirme a transação e consulte os itens do pedido e o estoque dos produtos 2, 5 e 7.
-- Para obter o id do pedido recém-criado, use currval(pg_get_serial_sequence('pedido', 'pedido_id')). 69

set search_path to Schemas ;


begin

insert into pedido (cliente_id, status)
values (3, 'PENDENTE')

insert into item_pedido (pedido_id, produto_id, quantidade, preco_unitario)
select currval(pg_get_serial_sequence('pedido', 'pedido_id')), p.produto_id, v.qtd,p.preco
from (values (2, 2), (5, 1)) as v(produto_id, qtd)
join produto p on p.produto_id = v.produto_id;

update produto
set estoque = estoque - 2
where produto_id = 2;

update produto
set estoque = estoque - 1
where produto_id = 5;

savepoint brinde;

insert into item_pedido (pedido_id, produto_id, quantidade, preco_unitario)
select currval(pg_get_serial_sequence('pedido', 'pedido_id')),
       produto_id, 1, preco
from produto
where produto_id = 7;

update produto
set estoque = estoque - 1
where produto_id = 7;

rollback to savepoint brinde;

update pedido
set status = 'CONFIRMADO'
where pedido_id = currval(pg_get_serial_sequence('pedido', 'pedido_id'))

select ip.produto_id, p.nome, ip.quantidade, ip.preco_unitario
from item_pedido ip
join produto p on p.produto_id = ip.produto_id
where ip.pedido_id = currval(pg_get_serial_sequence('pedido', 'pedido_id'))

select produto_id, nome, estoque
from produto
where produto_id in (2, 5 ,  7);
