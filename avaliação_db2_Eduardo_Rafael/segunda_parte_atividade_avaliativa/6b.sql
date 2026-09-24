-- 6B — Perfil de suporte
-- Crie uma role:

-- suporte_delivery
-- com permissão de login.

-- Ela deverá poder:

-- acessar o schema;
-- consultar clientes;
-- consultar pedidos;
-- consultar pagamentos;
-- atualizar somente as colunas:
-- status;
-- observacao;
-- da tabela pedidos.

-- Ela não deve poder alterar outras colunas de pedidos.

create role suporte_delivery login 

grant usage on schema avaliacao_delivery to suporte_delivery

grant select on avaliacao_delivery.clientes, avaliacao_delivery.pedidos, avaliacao_delivery.pagamentos to suporte_delivery

GRANT update (status,observacao) ON avaliacao_delivery.pedidos TO suporte_delivery;

select status, observacao from pedidos
