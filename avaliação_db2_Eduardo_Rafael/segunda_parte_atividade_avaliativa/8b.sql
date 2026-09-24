
-- Crie uma function:

-- fn_total_gasto_cliente
-- Ela deverá:

-- receber o ID do cliente;
-- utilizar somente pedidos nos status:
-- PREPARANDO;
-- SAIU_ENTREGA;
-- ENTREGUE;
-- retornar o total gasto pelo cliente.
-- Você pode reutilizar:

create or replace function fn_total_gasto_cliente(c_id bigint)
returns numeric
language plpgsql
as $$
declare
    v_total_cliente numeric;
begin

    select
        coalesce(sum(
            (
                select sum(i.quantidade * i.preco_unitario)
                from itens_pedido i
                where i.pedido_id = p.id
            )
            + p.taxa_entrega
            - p.desconto
        ), 0)
    into v_total_cliente
    from pedidos p
    where p.cliente_id = c_id
      and p.status in (
          'PREPARANDO',
          'SAIU_ENTREGA',
          'ENTREGUE'
      );

    return v_total_cliente;

end;
$$;
