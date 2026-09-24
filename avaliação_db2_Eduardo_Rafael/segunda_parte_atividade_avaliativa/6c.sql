
-- 6C — Alteração de permissão
-- Por decisão da empresa, o suporte não poderá mais modificar o status diretamente.

-- Revogue somente a permissão de atualização da coluna:

-- status
-- mantendo a possibilidade de atualizar:

-- observacao

revoke update (status) on avaliacao_delivery.pedidos from suporte_delivery


