select nome,
       categoria,
       avaliacao,
       case
           when avaliacao >= 4.7 then 'EXCELENTE'
           when avaliacao >= 4.3 then 'MUITO BOM'
           when avaliacao >= 4.0 then 'BOM'
           else 'ATENÇÃO'
       end as classificacao
from restaurantes
where ativo = true;
