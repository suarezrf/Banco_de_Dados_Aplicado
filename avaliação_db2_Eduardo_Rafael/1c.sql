select cidade,
       count(*) as total_clientes,
       sum(case when ativo = true then 1 else 0 end) as ativos,
       sum(case when ativo = false then 1 else 0 end) as inativos
from clientes
group by cidade
order by cidade;
