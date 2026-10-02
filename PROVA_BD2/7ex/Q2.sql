
-- Questão 2 — Níveis de isolamento
-- Escreva roteiros de duas sessões usando o preço do produto 5 e a consulta SELECT COUNT(*) FROM produto WHERE preco < 300.

-- a) Com a Sessão A em READ COMMITTED, demonstre leitura não repetível e leitura fantasma. A lê o preço e a contagem. B, 
-- em transação própria, muda o preço do produto 5 para 599.00 e insere um produto de 45.00. A lê de novo depois do COMMIT de B.

-- b) Devolva o banco ao estado inicial (preço 499.00, produto novo removido) e repita o roteiro com a Sessão A em REPEATABLE READ.

-- a
begin isolation level read committed

select preco from produto 
where produto_id = 5

select count(*) from produto 
where preco < 300

begin

update produto set  preco = 599.00 where produto_id = 5
insert into produto (nome,preco, estoque) values ('produto teste', 45.00, 10)
commit;

select preco
from produto where produto_id = 5
select count(*)
from produto where preco < 300

commit;

-- ¯\_(ツ)_/¯
-------------------------------------------------------------------------------
--b 

begin isolation level repeatable read
select preco 
from produto where produto_id = 5
select count(*) 
from produto where preco < 300

begin
update produto set preco = 599.00 where produto_id = 5
insert into produto (nome,preco, estoque) values ('produto teste' , 45.00, 10)
commit;
select preco  from produto where produto_id = 5
select count(*) 
from produto where preco < 300
commit;
