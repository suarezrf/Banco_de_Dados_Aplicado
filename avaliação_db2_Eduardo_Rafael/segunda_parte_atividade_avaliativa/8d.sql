-- Execute pelo menos três testes:

-- cancelamento válido;
-- tentativa de cancelar pedido ENTREGUE;
-- tentativa de cancelar pedido já CANCELADO.
-- Mantenha os comandos e os resultados esperados no arquivo.

select id, status, observacao
from pedidos
where status not in ('ENTREGUE', 'CANCELADO')
limit 5;

call sp_cancelar_pedido(
    10,
    'Cliente solicitou cancelamento'
);

select id, status, observacao
from pedidos
where id = 10;

select *
from historico_status
where pedido_id = 10;

select *
from pagamentos
where pedido_id = 10;

select id, status
from pedidos
where status = 'ENTREGUE'
limit 5;

call sp_cancelar_pedido(
    1,
    'Tentativa de cancelamento de pedido entregue'
);

call sp_cancelar_pedido(
    10,
    'Tentativa de cancelar novamente'
);

select id, status, observacao
from pedidos
where id = 10;

