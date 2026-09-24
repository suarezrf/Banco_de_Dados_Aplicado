--4A — Simulação com ROLLBACK
--Dentro de uma transação:

--altere o status do pedido para SAIU_ENTREGA;
--atualize a observação para Teste de atualização pelo suporte;
--insira um registro em historico_status;
--consulte as duas tabelas para confirmar as alterações temporárias;
--execute ROLLBACK;
--consulte novamente e prove que as alterações foram desfeitas.

select * from pedidos
select * from historico_status

BEGIN;
UPDATE pedidos SET status = 'SAIU_ENTREGA' WHERE id = 30002;
UPDATE pedidos SET observacao = 'Teste de atualização pelo suporte' WHERE id = 30002;


insert into historico_status (
	pedido_id,
	status_anterior,
	status_novo,
	motivo

)
values (
	30002,
	'PREPARANDO',
	'SAIU_ENTREGA',
	'Teste de atualização pelo suporte'

);

select * from pedidos where id = 30002

select * from historico_status where pedido_id = 30002

ROLLBACK;
