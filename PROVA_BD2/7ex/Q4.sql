
-- Questão 4 Trigger de auditoria
-- a) Crie uma trigger `AFTER UPDATE` em~ `conta` que registre em `auditoria_conta` o `conta_id`, 
-- o saldo anterior e o saldo novo, somente quando o saldo realmente mudar.
-- b) Escreva os testes, nesta ordem, e consulte `auditoria_conta` no fim:

-- 1. uma transação que transfere 100 da conta 1 para a conta 2 (dois UPDATE), confirmada com COMMIT;
-- 2. uma transação que transfere 50 da conta 1 para a conta 3, terminada com ROLLBACK;
-- 3. um UPDATE em `conta` que não muda o saldo.
-- ei pia senti a aura lá do lobby 

create or replace function fn_auditoria_conta()
returns trigger as $$
begin
    insert into auditoria_conta (conta_id, saldo_anterior, saldo_novo)
    values (old.conta_id, old.saldo, new.saldo)
    return null
end
$$ language plpgsql

create trigger trg_auditoria_conta
after update on conta
for each row
when (old.saldo is distinct from new.saldo)
execute function fn_auditoria_conta()

begin
update conta 
set saldo = saldo - 100 
where conta_id = 1
update conta 
set saldo = saldo + 100 
where conta_id = 2
commit

begin
update conta set saldo = saldo - 50 where conta_id = 1
update conta set saldo = saldo + 50 where conta_id = 3
rollback
update conta set saldo = saldo where conta_id = 1

select * from auditoria_conta

