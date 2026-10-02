
-- Questão 7 — View materializada
-- a) Crie a view materializada mv_faturamento_mensal (mes, qtd_pedidos, faturamento),
-- em que faturamento é a soma de quantidade * preco_unitario, ignorando pedidos CANCELADO.
--Crie também o índice que permite atualizá-la sem bloquear quem está lendo.

-- b) Demonstre a defasagem: consulte a linha de dezembro de 2025; insira um pedido PAGO
-- em 15/12/2025 para o cliente 1 com 1 unidade do produto 11; consulte de novo; atualize a view sem bloquear leitores; consulte mais uma vez.

-- a)
create materialized view mv_faturamento_mensal as
select date_trunc('month', p.data_pedido)::date as mes,
       count(distinct p.pedido_id) as qtd_pedidos,
       sum(i.quantidade * i.preco_unitario) as faturamento
from pedido p
join item_pedido i on i.pedido_id = p.pedido_id
where p.status <> 'CANCELADO'
group by date_trunc('month', p.data_pedido)::date;

create unique index idx_mv_faturamento_mes on mv_faturamento_mensal (mes);

-- b)
select * from mv_faturamento_mensal where mes = '2025-12-01';

insert into pedido (cliente_id, data_pedido, status)
values (1, '2025-12-15', 'PAGO');

insert into item_pedido (pedido_id, produto_id, quantidade, preco_unitario)
select currval(pg_get_serial_sequence('pedido', 'pedido_id')), produto_id, 1, preco
from produto
where produto_id = 11;

select * from mv_faturamento_mensal where mes = '2025-12-01';

refresh materialized view concurrently mv_faturamento_mensal;

select * from mv_faturamento_mensal where mes = '2025-12-01';
