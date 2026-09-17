select r.nome as restaurante,pr.nome as produto, pr.preco,
       (
	   	   select avg(pr2.preco)
           from produtos pr2
           where pr2.restaurante_id = pr.restaurante_id
       ) as media_restaurante
from produtos pr
join restaurantes r
    on r.id = pr.restaurante_id
where pr.preco > (
    select avg(pr2.preco)
    from produtos pr2
    where pr2.restaurante_id = pr.restaurante_id
);

