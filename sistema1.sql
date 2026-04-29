insert into cliente (nome_cliente,email_cliente)
values
('Tauani','Tau@gmail.com'),
('Augusto','Augusto@gmail.com');

insert into produto (nome_produto,preco_produto)
values
('cafe','30.00'),
('arroz','35.00');

insert into venda (data_venda, id_cliente)
values
('2026-01-02',1),
('2026-02-02',2);

insert into item_venda (id_venda, id_produto, quantidade_item, preco_unitario)
values
(3,1,'3','25.90'),
(4,2,'4','10.80');



