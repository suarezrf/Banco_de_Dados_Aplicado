
-- 7A — Tabela particionada
-- Crie:

-- pedidos_historico_part
-- com as colunas:

-- pedido_id;
-- cliente_id;
-- restaurante_id;
-- data_pedido;
-- status;
-- canal;
-- valor_total.
-- A tabela deverá utilizar:

-- PARTITION BY RANGE (data_pedido)

create table pedidos_historico_part (
	pedido_id bigint,
	cliente_id bigint,
	restaurante_id bigint,
	data_pedido timestamp,
	status varchar(30),
	canal varchar(30),
	valor_total NUMERIC

)
partition by range(data_pedido)


