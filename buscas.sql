-- buscar produto dentro da venda
-- query - select - leitura
-- select (nome das tabelas)= filtro
select id_produto, preco_unitario
from item_venda
where id_venda = 3 and id_produto = 1;

-- pesquisando por nome
select iv.preco_unitario,nome_produto
from item_venda as iv -- as = apelido
join produto as p on iv.id_produto = p.id_produto    -- juntar
where iv.id_venda = 2 and p.nome_produto like'%arroz%'; 

-- buscando todas as vendas de um cliente
select *
from venda
where id_cliente = 1;

-- buscar produto mais vendido
select p.nome_produto, sum(iv.quantidade_item)as total_vendido
from item_venda as iv
join produto p on p.id_produto = id_produto
group by p.nome_produto;