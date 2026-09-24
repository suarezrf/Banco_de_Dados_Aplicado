
-- 8C — Stored Procedure para cancelamento
-- Crie uma stored procedure:

-- sp_cancelar_pedido
-- Parâmetros:

-- pedido_id
-- motivo
-- Regras:

-- verificar se o pedido existe;
-- impedir o cancelamento de pedidos já ENTREGUE;
-- impedir novo cancelamento de pedidos já CANCELADO;
-- alterar o status para CANCELADO;
-- gravar o motivo em observacao;
-- inserir o histórico da alteração em historico_status;
-- caso exista pagamento com status APROVADO, alterá-lo para ESTORNADO;
-- utilizar RAISE EXCEPTION para operações inválidas.

create or replace procedure sp_cancelar_pedido(
    p_pedido_id bigint,
    p_motivo text
)
language plpgsql
as $$
declare
    v_status_atual text;
begin

    -- 1. verificar se o pedido existe
    select status
    into v_status_atual
    from pedidos
    where id = p_pedido_id;

    if not found then
        raise exception 'Pedido % não existe', p_pedido_id;
    end if;


    -- 2. impedir cancelamento de pedido entregue
    if v_status_atual = 'ENTREGUE' then
        raise exception 'Não é possível cancelar um pedido já entregue';
    end if;


    -- 3. impedir novo cancelamento
    if v_status_atual = 'CANCELADO' then
        raise exception 'O pedido já está cancelado';
    end if;


    -- 4 e 5. alterar status e observação
    update pedidos
    set
        status = 'CANCELADO',
        observacao = p_motivo
    where id = p_pedido_id;


    -- 6. registrar histórico
    insert into historico_status (
        pedido_id,
        status_anterior,
        status_novo,
        motivo
    )
    values (
        p_pedido_id,
        v_status_atual,
        'CANCELADO',
        p_motivo
    );


    -- 7. estornar pagamento aprovado
    update pagamentos
    set status = 'ESTORNADO'
    where pedido_id = p_pedido_id
      and status = 'APROVADO';

end;
$$;
