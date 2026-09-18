

select c.id,c.nome, c.email, c.cidade
from clientes c
where c.ativo = true
  and not exists (
      select 1
      from emails_bloqueados eb
      where eb.email = c.email
  );
