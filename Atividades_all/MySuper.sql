create database mysuper;
use mysuper;

CREATE TABLE categorias (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nome_categoria VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE fornecedores (
    id_fornecedor INT PRIMARY KEY AUTO_INCREMENT,
    nome_fornecedor VARCHAR(100) NOT NULL,
    contato_fornecedor VARCHAR(100),
    endereco_fornecedor VARCHAR(200)
);

CREATE TABLE filiais (
    id_filial INT PRIMARY KEY AUTO_INCREMENT,
    nome_filial VARCHAR(100) NOT NULL,
    endereco_filial VARCHAR(200) NOT NULL
);

CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome_cliente VARCHAR(100) NOT NULL,
    telefone_cliente CHAR(11) UNIQUE,
    endereco_cliente VARCHAR(200),
    pontos_fidelidade INT DEFAULT 0 CHECK (pontos_fidelidade >= 0)
);

-- 2. Tabelas Dependentes (com chaves estrangeiras)
CREATE TABLE produto (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome_produto VARCHAR(100) NOT NULL,
    descricao_produto TEXT,
    preco_produto DECIMAL(10,2) NOT NULL CHECK (preco_produto >= 0),
    quantidade_estoque INT NOT NULL CHECK (quantidade_estoque >= 0),
    id_categoria INT NOT NULL,
    id_fornecedor INT NOT NULL,
    id_filial INT NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria),
    FOREIGN KEY (id_fornecedor) REFERENCES fornecedores(id_fornecedor),
    FOREIGN KEY (id_filial) REFERENCES filiais(id_filial)
);

CREATE TABLE funcionarios (
    id_funcionario INT PRIMARY KEY AUTO_INCREMENT,
    nome_funcionario VARCHAR(100) NOT NULL,
    cargo_funcionario VARCHAR(50) NOT NULL,
    salario_funcionario DECIMAL(10,2) NOT NULL CHECK (salario_funcionario >= 0),
    data_contratacao DATE NOT NULL,
    id_filial INT NOT NULL,
    FOREIGN KEY (id_filial) REFERENCES filiais(id_filial)
);

CREATE TABLE vendas (
    id_venda INT PRIMARY KEY AUTO_INCREMENT,
    data DATE NOT NULL,
    total_venda DECIMAL(10,2) NOT NULL CHECK (total_venda >= 0),
    id_cliente INT,
    id_funcionario INT NOT NULL,
    id_filial INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_funcionario) REFERENCES funcionarios(id_funcionario),
    FOREIGN KEY (id_filial) REFERENCES filiais(id_filial)
);

CREATE TABLE itensvenda (
    id_item_venda INT PRIMARY KEY AUTO_INCREMENT,
    id_venda INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade_venda INT NOT NULL CHECK (quantidade_venda > 0),
    total_venda DECIMAL(10,2) NOT NULL CHECK (total_venda >= 0),
    FOREIGN KEY (id_venda) REFERENCES vendas(id_venda),
    FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
);

CREATE TABLE compras (
    id_compra INT PRIMARY KEY AUTO_INCREMENT,
    data DATE NOT NULL,
    total_compra DECIMAL(10,2) NOT NULL CHECK (total_compra >= 0),
    id_fornecedor INT NOT NULL,
    id_filial INT NOT NULL,
    FOREIGN KEY (id_fornecedor) REFERENCES fornecedores(id_fornecedor),
    FOREIGN KEY (id_filial) REFERENCES filiais(id_filial)
);

CREATE TABLE itenscompra (
    id_item_compra INT PRIMARY KEY AUTO_INCREMENT,
    id_compra INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade_compra INT NOT NULL CHECK (quantidade_compra > 0),
    total_compra DECIMAL(10,2) NOT NULL CHECK (total_compra >= 0),
    FOREIGN KEY (id_compra) REFERENCES compras(id_compra),
    FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
);

-- INSERTS  :

INSERT INTO categorias (nome_categoria) VALUES 
('Alimentos'),
('Bebidas'),
('Limpeza'),
('Higiene Pessoal'),
('Hortifruti');

INSERT INTO fornecedores (nome_fornecedor, contato_fornecedor, endereco_fornecedor) VALUES 
('Distribuidora Aliança', '(11) 99999-1111', 'Rua das Indústrias, 100'),
('Bebidas do Brasil S.A.', '(21) 98888-2222', 'Av. Central, 500'),
('Química Suprema', '(31) 97777-3333', 'Av. dos Químicos, 1050'),
('Sabor da Terra Orgânicos', '(41) 96666-4444', 'Sítio Primavera, KM 12'),
('Logística Global Atacado', '(51) 95555-5555', 'Rodovia BR-101, Km 45');

INSERT INTO filiais (nome_filial, endereco_filial) VALUES 
('Supermercado Central', 'Av. Principal, 1000 - Centro'),
('Supermercado Norte', 'Rua das Flores, 250 - Bairro Norte'),
('Supermercado Sul', 'Av. Interlagos, 1500 - Bairro Sul'),
('Supermercado Express', 'Rua XV de Novembro, 88 - Estação'),
('Supermercado Praia', 'Av. Beira Mar, 400 - Litoral');

INSERT INTO clientes (nome_cliente, telefone_cliente, endereco_cliente, pontos_fidelidade) VALUES 
('Carlos Silva', '11912345678', 'Rua A, 123', 50),
('Ana Souza', '21987654321', 'Av. B, 456', 120),
('Marcos Oliveira', '31955554444', 'Rua C, 789', 0),
('Julia Costa', '41933332222', 'Alameda D, 12', 215),
('Roberto Santos', '51911110000', 'Praça E, 55', 10);

INSERT INTO produto (nome_produto, descricao_produto, preco_produto, quantidade_estoque, id_categoria, id_fornecedor, id_filial) VALUES 
('Arroz Integral 1kg', 'Arroz integral tipo 1', 6.50, 150, 1, 1, 1),
('Refrigerante Cola 2L', 'Garrafa pet de 2 litros', 8.90, 300, 2, 2, 1),
('Detergente Neutro 500ml', 'Lava-louças biodegradável', 2.20, 500, 3, 3, 2),
('Sabonete Barra 90g', 'Fragrância suave com hidratante', 3.10, 400, 4, 5, 3),
('Banana Prata Kg', 'Banana prata fresca da região', 5.99, 80, 5, 4, 1);

INSERT INTO funcionarios (nome_funcionario, cargo_funcionario, salario_funcionario, data_contratacao, id_filial) VALUES 
('Fernanda Lima', 'Gerente', 4500.00, '2023-01-15', 1),
('Pedro Alvares', 'Operador de Caixa', 1800.00, '2024-03-10', 1),
('Lucas Martins', 'Repositor', 1650.00, '2024-05-20', 2),
('Camila Rodrigues', 'Atendente de SAC', 1900.00, '2023-11-01', 3),
('Bruno Souza', 'Fiscal de Loja', 2100.00, '2025-02-18', 1);

INSERT INTO vendas (data, total_venda, id_cliente, id_funcionario, id_filial) VALUES 
('2026-06-01', 21.90, 1, 2, 1),
('2026-06-02', 17.80, 2, 2, 1),
('2026-06-03', 6.60, 3, 3, 2),
('2026-06-04', 31.00, 4, 4, 3),
('2026-06-05', 11.98, 5, 2, 1);

INSERT INTO itensvenda (id_venda, id_produto, quantidade_venda, total_venda) VALUES 
(1, 1, 2, 13.00), 
(1, 4, 2, 6.20),  
(2, 2, 2, 17.80), 
(3, 3, 3, 6.60),  
(4, 4, 10, 31.00);

INSERT INTO compras (data, total_compra, id_fornecedor, id_filial) VALUES 
('2026-05-10', 650.00, 1, 1),
('2026-05-12', 1335.00, 2, 1),
('2026-05-15', 440.00, 3, 2),
('2026-05-18', 620.00, 5, 3),
('2026-05-20', 239.60, 4, 1);

INSERT INTO itenscompra (id_compra, id_produto, quantidade_compra, total_compra) VALUES 
(1, 1, 100, 650.00),
(2, 2, 150, 1335.00),
(3, 3, 200, 440.00),
(4, 4, 200, 620.00),
(5, 5, 40, 239.60);

-- CONSULTAS:
SELECT * FROM produto;

SELECT nome_produto, preco_produto FROM produto;

SELECT nome_produto, quantidade_estoque
FROM produto
WHERE quantidade_estoque < 50;

SELECT nome_cliente, pontos_fidelidade
FROM clientes
WHERE pontos_fidelidade > 100;

SELECT nome_funcionario, cargo_funcionario, salario_funcionario
FROM funcionarios
ORDER BY salario_funcionario DESC;

SELECT *
FROM produto
WHERE id_categoria = 5;

SELECT * FROM vendas
WHERE total_venda > 30;

SELECT * FROM produto
WHERE nome_produto LIKE '%Ar%';

SELECT * FROM clientes
ORDER BY nome_cliente;

SELECT nome_produto, preco_produto
FROM produto
WHERE preco_produto BETWEEN 5 AND 100
ORDER BY preco_produto;

SELECT produto.nome_produto, categorias.nome_categoria
FROM produto
JOIN categorias
ON produto.id_categoria = categorias.id_categoria
ORDER BY nome_categoria;

SELECT produto.nome_produto, fornecedores.nome_fornecedor
FROM produto
JOIN fornecedores
ON produto.id_fornecedor = fornecedores.id_fornecedor;

SELECT vendas.id_venda, clientes.nome_cliente
FROM vendas
JOIN clientes
ON vendas.id_cliente = clientes.id_cliente;

SELECT vendas.id_venda, funcionarios.nome_funcionario
FROM vendas
JOIN funcionarios
ON vendas.id_funcionario = funcionarios.id_funcionario;

SELECT produto.nome_produto, filiais.nome_filial
FROM produto
JOIN filiais
ON produto.id_filial = filiais.id_filial;

SELECT itensvenda.quantidade_venda, produto.nome_produto
FROM itensvenda
JOIN produto
ON itensvenda.id_produto = produto.id_produto;

SELECT compras.id_compra, fornecedores.nome_fornecedor
FROM compras
JOIN fornecedores
ON compras.id_fornecedor = fornecedores.id_fornecedor;

SELECT funcionarios.nome_funcionario, filiais.nome_filial
FROM funcionarios
JOIN filiais
ON funcionarios.id_filial = filiais.id_filial;

SELECT clientes.nome_cliente, vendas.total_venda
FROM clientes
JOIN vendas
ON clientes.id_cliente = vendas.id_cliente;

SELECT vendas.id_venda, produto.nome_produto
FROM itensvenda
JOIN produto
ON itensvenda.id_produto = produto.id_produto
JOIN vendas
ON itensvenda.id_venda = vendas.id_venda;

SELECT id_categoria, COUNT(*)
FROM produto
GROUP BY id_categoria;

SELECT id_cliente, SUM(total_venda)
FROM vendas
GROUP BY id_cliente;

SELECT cargo_funcionario, AVG(salario_funcionario)
FROM funcionarios
GROUP BY cargo_funcionario;

SELECT id_filial, COUNT(*)
FROM funcionarios
GROUP BY id_filial;

SELECT id_filial, SUM(total_venda)
FROM vendas
GROUP BY id_filial;

SELECT id_fornecedor, COUNT(*)
FROM Produtos
GROUP BY id_fornecedor;

SELECT id_fornecedor, SUM(total_compra)
FROM compras
GROUP BY id_fornecedor;

SELECT id_categoria, AVG(preco_produto)
FROM produto
GROUP BY id_categoria;

SELECT nome_cliente, SUM(pontos_fidelidade)
FROM clientes
GROUP BY nome_cliente;

SELECT id_produto, SUM(quantidade_venda)
FROM itensvenda
GROUP BY id_produto;

SELECT COUNT(*) FROM produto;

SELECT SUM(quantidade_estoque)
FROM produto;

SELECT AVG(preco_produto)
FROM produto;

SELECT MAX(preco_produto)
FROM produto;

SELECT MIN(preco_produto)
FROM produto;

SELECT COUNT(*)
FROM vendas;

SELECT SUM(total_venda)
FROM vendas;

SELECT AVG(salario_funcionario)
FROM funcionarios;

SELECT MAX(salario_funcionario)
FROM funcionarios;

SELECT MIN(salario_funcionario)
FROM funcionarios;

SELECT *
FROM produto
WHERE preco_produto = (
   SELECT MAX(preco_produto)
   FROM produto
);

SELECT *
FROM produto
WHERE preco_produto = (
   SELECT MIN(preco_produto)
   FROM produto
);

SELECT *
FROM clientes
WHERE pontos_fidelidade > (
   SELECT AVG(pontos_fidelidade)
   FROM clientes
);

SELECT *
FROM funcionarios
WHERE salario_funcionario = (
   SELECT MAX(salario_funcionario)
   FROM funcionarios
);

SELECT *
FROM produto
WHERE quantidade_estoque < (
   SELECT AVG(quantidade_estoque)
   FROM produto
);

SELECT nome_cliente
FROM clientes
WHERE id_cliente IN (
   SELECT id_cliente
   FROM vendas
);

SELECT nome_produto
FROM produto
WHERE id_produto IN (
   SELECT id_produto
   FROM itensvenda
);

SELECT nome_produto
FROM produto
WHERE id_produto NOT IN (
   SELECT id_produto
   FROM itensvenda
);

SELECT *
FROM filiais
WHERE id_filial = (
   SELECT id_filial
   FROM vendas
   GROUP BY id_filial
   ORDER BY SUM(total_venda) DESC
   LIMIT 1
);


SELECT nome_produto, preco_produto
FROM produto
WHERE preco_produto > (
   SELECT AVG(preco_produto)
   FROM produto
);


















