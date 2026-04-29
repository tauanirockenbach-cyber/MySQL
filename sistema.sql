create database sistema;
use sistema;

create table cliente(
id_cliente int auto_increment primary key,
nome_cliente varchar(100) not null,
email_cliente varchar(30) not null unique
);
create table produto(
id_produto int auto_increment primary key,
nome_produto varchar(100) not null,
preco_produto decimal(5,2) not null
);
create table venda(
id_venda int auto_increment primary key,
data_venda date not null, 
id_cliente int,
foreign key(id_cliente) references cliente (id_cliente)
);
create table item_venda(
id_venda int,
id_produto int,
quantidade_item int not null,
preco_unitario decimal(5,2) not null,
primary key(id_venda, id_produto),
foreign key (id_venda) references venda(id_venda),
foreign key (id_produto) references produto(id_produto)
);