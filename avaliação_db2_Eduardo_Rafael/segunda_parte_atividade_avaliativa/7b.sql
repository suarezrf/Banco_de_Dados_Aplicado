-- Crie:

-- pedidos_2025
-- pedidos_2026_s1
-- pedidos_2026_s2
-- Faixas:

-- pedidos_2025
-- 01/01/2025 até 01/01/2026

-- pedidos_2026_s1
-- 01/01/2026 até 01/07/2026

-- pedidos_2026_s2
-- 01/07/2026 até 01/01/2027

create table pedidos_2025 partition of pedidos_historico_part for values from ('01-01-2025') to ('01-01-2026');

create table pedidos_2026_s1 partition of pedidos_historico_part for values from ('01-01-2026') to ('01-07-2026');

create table pedidos_2026_s2 partition of pedidos_historico_part for values from ('01-07-2026') to ('01-01-2027');
