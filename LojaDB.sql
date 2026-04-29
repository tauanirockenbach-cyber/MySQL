-- Categorias
INSERT INTO Categoria (nome) VALUES
('Alimentos'),
('Higiene'),
('Bebidas');

-- Produtos
INSERT INTO Produto (nome, preco, id_categoria) VALUES
('Arroz 5kg', 25.00, 1),
('Feijão 1kg', 8.50, 1),
('Sabonete', 3.00, 2),
('Shampoo', 12.00, 2),
('Refrigerante', 6.50, 3);

-- Clientes
INSERT INTO Cliente (nome, telefone) VALUES
('João', '999999999'),
('Maria', '888888888');

-- Vendas
INSERT INTO Venda (data, id_cliente) VALUES
('2025-04-01', 1),
('2025-04-02', 2);

-- Itens da venda
INSERT INTO ItemVenda (id_venda, id_produto, quantidade, subtotal) VALUES
(1, 1, 2, 50.00),
(1, 3, 3, 9.00),
(2, 2, 1, 8.50),
(2, 5, 2, 13.00);