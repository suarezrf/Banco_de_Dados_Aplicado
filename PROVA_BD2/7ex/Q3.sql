
-- Questão 3 — Atualização perdida
-- Duas sessões vendem 1 unidade do produto 1 ao mesmo tempo. Antes de cada item, volte o estoque do produto 1 para 10.

-- a) Escreva um roteiro que reproduza a atualização perdida. Cada sessão lê o estoque com SELECT
-- e grava o valor calculado como número literal (SET estoque = 9). No fim, consulte o estoque.

update produto set estoque = 10 -- volte o estoque do produto 1 para 10. ~ fora lula 
where produto_id = 1

------------------------

begin;
select estoque from produto where produto_id = 1

begin;
select estoque from produto where produto_id = 1

update produto set estoque = 9 where produto_id = 1
commit;

update produto set estoque = 9 where produto_id = 1
commit;

select estoque from produto where produto_id = 1


-- b) Reescreva o roteiro, ainda em READ COMMITTED, usando SELECT ... FOR UPDATE, de modo que o estoque termine em 8.


update produto set estoque = 10 
where produto_id = 1

begin isolation level read committed
select estoque from produto where produto_id = 1 for update
begin isolation level read committed
select estoque from produto where produto_id = 1 for update
update produto set estoque = 9 where produto_id = 1
commit
update produto set estoque = 8 where produto_id = 1
commit
select estoque from produto where produto_id = 1

