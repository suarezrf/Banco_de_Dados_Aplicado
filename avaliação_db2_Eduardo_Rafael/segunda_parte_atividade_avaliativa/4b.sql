--4B — Operação confirmada
--Escolha outro pedido com status PREPARANDO.

--Repita o processo anterior, mas desta vez finalize com:

--COMMIT
--Demonstre que as alterações permaneceram após a confirmação.


BEGIN;
UPDATE pedidos SET status = 'SAIU_ENTREGA' WHERE id = 30006;
UPDATE pedidos SET observacao = 'Teste de atualização pelo suporte' WHERE id = 30006;


insert into historico_status (
	pedido_id,
	status_anterior,
	status_novo,
	motivo

)
values (
	300017
	'PREPARANDO',
	'SAIU_ENTREGA',
	'Teste de atualização pelo suporte'

);

select * from pedidos where id = 30006

select * from historico_status where pedido_id = 30006

commit;
