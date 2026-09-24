--6A — Perfil de BI
--Crie uma role:

--bi_delivery
--com permissão de login.

--Ela deverá poder:

--acessar o schema avaliacao_delivery;
--consultar clientes;
--consultar restaurantes;
--consultar pedidos;
--consultar itens_pedido;
--consultar vw_painel_pedidos.
--Ela não deverá possuir permissões de INSERT, UPDATE ou DELETE em pedidos.

--Utilize GRANT e REVOKE.


create role bi_delivery login;

grant usage on schema avaliacao_delivery to bi_delivery;

grant select on avaliacao_delivery.clientes, avaliacao_delivery.restaurantes, avaliacao_delivery.pedidos,avaliacao_delivery.itens_pedido to bi_delivery;

grant select on avaliacao_delivery.vw_painel_pedidos to bi_delivery;

revoke insert, update, delete on avaliacao_delivery.pedidos from bi_delivery;
