CREATE USER IF NOT EXISTS 'Tauani'@'localhost' IDENTIFIED BY '123';
GRANT ALL PRIVILEGES ON *.* TO 'Tauani'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;

CREATE DATABASE SorveteriaDB;
USE SorveteriaDB;

CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome_cliente VARCHAR(100) NOT NULL,
    telefone_cliente VARCHAR(15),
    email_cliente VARCHAR(100),
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE funcionarios (
    id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    nome_funcionario VARCHAR(100) NOT NULL,
    cargo_funcionario VARCHAR(50) NOT NULL,
    salario_funcionario DECIMAL(10,2) NOT NULL
);

CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome_categoria VARCHAR(50) NOT NULL
);

CREATE TABLE produtos (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    id_categoria INT,
    nome_produto VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    estoque_atual INT DEFAULT 0,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    id_funcionario INT,
    data_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_pedido DECIMAL(10,2) DEFAULT 0.00,
    forma_pagamento VARCHAR(30) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_funcionario) REFERENCES funcionarios(id_funcionario)
);

CREATE TABLE itens_pedido (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT,
    id_produto INT,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido) ON DELETE CASCADE,
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);

INSERT INTO categorias (nome_categoria) VALUES 
('Sorvete de Massa'),
('Picolé'),
('Açaí'),
('Adicionais'),
('Bebidas');

INSERT INTO produtos (id_categoria, nome_produto, preco, estoque_atual) VALUES 
(1, 'Sorvete Chocolate 1L', 26.00, 15),
(1, 'Sorvete Morango 1L', 26.00, 12),
(1, 'Sorvete Baunilha 1L', 24.00, 8),
(2, 'Picolé de Limão', 4.50, 45),
(2, 'Picolé de Brigadeiro', 6.00, 30),
(3, 'Copo de Açaí 500ml', 18.00, 20),
(4, 'Leite Condensado (Adicional)', 2.50, 100),
(4, 'Granulado (Adicional)', 1.50, 80),
(5, 'Água Mineral 500ml', 3.50, 50);

INSERT INTO clientes (nome_cliente, telefone_cliente, email_cliente) VALUES 
('Mariana Souza', '11999998888', 'mariana@email.com'),
('Lucas Oliveira', '11988887777', 'lucas@email.com'),
('Beatriz Costa', '11977776666', 'beatriz@email.com');

INSERT INTO funcionarios (nome_funcionario, cargo_funcionario, salario_funcionario) VALUES 
('Carlos Silva', 'Atendente', 2100.00),
('Ana Santos', 'Gerente', 3500.00);

INSERT INTO pedidos (id_cliente, id_funcionario, total_pedido, forma_pagamento) 
VALUES (1, 1, 30.50, 'Dinheiro');

INSERT INTO pedidos (id_cliente, id_funcionario, total_pedido, forma_pagamento) 
VALUES (2, 2, 22.50, 'Cartão de Débito');

INSERT INTO pedidos (id_cliente, id_funcionario, total_pedido, forma_pagamento) 
VALUES (3, 1, 26.00, 'Pix');

INSERT INTO itens_pedido (id_pedido, id_produto, quantidade, preco_unitario) VALUES 
(1, 1, 1, 26.00), 
(1, 4, 1, 4.50);

INSERT INTO itens_pedido (id_pedido, id_produto, quantidade, preco_unitario) VALUES 
(2, 6, 1, 18.00),
(2, 7, 1, 2.50),
(2, 8, 1, 1.50);

INSERT INTO itens_pedido (id_pedido, id_produto, quantidade, preco_unitario) VALUES 
(3, 2, 1, 26.00);


CREATE USER IF NOT EXISTS 'programador'@'localhost' IDENTIFIED BY '1234';

GRANT SELECT, INSERT, UPDATE ON SorveteriaDB.produtos TO 'programador'@'localhost';
FLUSH PRIVILEGES;

-- permitidas
SELECT * FROM produtos;

INSERT INTO produtos (id_categoria, nome_produto, preco, estoque_atual) 
VALUES (2, 'Picolé de Uva', 4.50, 40);
UPDATE produtos SET preco = 28.00 WHERE id_produto = 1;

-- bloqueadas
SELECT * FROM clientes;
DELETE FROM produtos WHERE id_produto = 4;
DROP TABLE categorias;