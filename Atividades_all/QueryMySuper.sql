use mysuper;
ALTER TABLE clientes RENAME TO clientesvip;
ALTER TABLE produto ADD marca VARCHAR(50);
ALTER TABLE produto DROP COLUMN marca;
ALTER TABLE clientesvip MODIFY telefone_cliente VARCHAR(20);
ALTER TABLE funcionarios RENAME COLUMN cargo_funcionario TO funcao_funcionario;

ALTER TABLE produto MODIFY nome_produto VARCHAR(200);
ALTER TABLE clientesvip MODIFY nome_cliente VARCHAR(100) NOT NULL;
ALTER TABLE clientesvip MODIFY endereco_cliente VARCHAR(200) NULL;
ALTER TABLE clientesvip MODIFY pontos_fidelidade INT DEFAULT 0;
ALTER TABLE itensvenda DROP FOREIGN KEY itensvenda_ibfk_1;
ALTER TABLE itenscompra DROP FOREIGN KEY itenscompra_ibfk_1;
ALTER TABLE vendas MODIFY id_venda BIGINT AUTO_INCREMENT;
ALTER TABLE itensvenda MODIFY id_venda BIGINT;
ALTER TABLE itensvenda ADD CONSTRAINT fk_itensvenda_vendas FOREIGN KEY (id_venda) REFERENCES vendas(id_venda);

ALTER TABLE produto DROP FOREIGN KEY produto_ibfk_2;
ALTER TABLE compras DROP FOREIGN KEY compras_ibfk_1;

ALTER TABLE fornecedores MODIFY id_fornecedor INT NOT NULL;

SET FOREIGN_KEY_CHECKS = 0;
SET sql_require_primary_key = 0;

ALTER TABLE fornecedores DROP PRIMARY KEY;
ALTER TABLE fornecedores ADD PRIMARY KEY(id_fornecedor);
ALTER TABLE fornecedores MODIFY id_fornecedor INT AUTO_INCREMENT;
ALTER TABLE produto ADD CONSTRAINT fk_produto_fornecedores FOREIGN KEY (id_fornecedor) REFERENCES fornecedores(id_fornecedor);
ALTER TABLE compras ADD CONSTRAINT fk_compras_fornecedores FOREIGN KEY (id_fornecedor) REFERENCES fornecedores(id_fornecedor);

ALTER TABLE itensvenda MODIFY id_produto INT NOT NULL;

ALTER TABLE vendas DROP FOREIGN KEY vendas_ibfk_1;
ALTER TABLE clientesvip MODIFY id_cliente INT NOT NULL;
ALTER TABLE clientesvip DROP PRIMARY KEY;
ALTER TABLE clientesvip ADD PRIMARY KEY(id_cliente);
ALTER TABLE clientesvip MODIFY id_cliente INT AUTO_INCREMENT;
ALTER TABLE vendas ADD CONSTRAINT fk_vendas_clientes FOREIGN KEY (id_cliente) REFERENCES clientesvip(id_cliente);

ALTER TABLE itenscompra DROP FOREIGN KEY itenscompra_ibfk_2;
ALTER TABLE itensvenda DROP FOREIGN KEY itensvenda_ibfk_2;
ALTER TABLE produto MODIFY id_produto INT AUTO_INCREMENT;
ALTER TABLE itenscompra ADD CONSTRAINT fk_itenscompra_produto FOREIGN KEY (id_produto) REFERENCES produto(id_produto);
ALTER TABLE itensvenda ADD CONSTRAINT fk_itensvenda_produto FOREIGN KEY (id_produto) REFERENCES produto(id_produto);

ALTER TABLE produto DROP FOREIGN KEY produto_ibfk_1;
ALTER TABLE produto ADD CONSTRAINT fk_categoria FOREIGN KEY(id_categoria) REFERENCES categorias(id_categoria);

ALTER TABLE vendas ADD CONSTRAINT fk_cliente_venda FOREIGN KEY(id_cliente) REFERENCES clientesvip(id_cliente);
ALTER TABLE itensvenda DROP FOREIGN KEY fk_itensvenda_vendas;
ALTER TABLE itensvenda ADD CONSTRAINT fk_venda_item FOREIGN KEY(id_venda) REFERENCES vendas(id_venda) ON DELETE CASCADE;
ALTER TABLE produto DROP FOREIGN KEY fk_produto_fornecedores;
ALTER TABLE produto ADD CONSTRAINT fk_fornecedor_prod FOREIGN KEY(id_fornecedor) REFERENCES fornecedores(id_fornecedor) ON UPDATE CASCADE;

ALTER TABLE clientesvip ADD CONSTRAINT unique_email UNIQUE(id_cliente);
ALTER TABLE clientesvip DROP INDEX unique_email;
ALTER TABLE produto ADD CONSTRAINT chk_preco_atualizado CHECK(preco_produto >= 0);
ALTER TABLE clientesvip ALTER pontos_fidelidade SET DEFAULT 0;
ALTER TABLE funcionarios MODIFY salario_funcionario DECIMAL(10,2) NOT NULL;

SET sql_require_primary_key = 1;
SET FOREIGN_KEY_CHECKS = 1;

SELECT * FROM clientesvip;

SELECT nome_cliente, telefone_cliente 
FROM clientesvip;

SELECT * FROM produto;

SELECT nome_produto, preco_produto 
FROM produto;

SELECT * FROM funcionarios;

SELECT nome_funcionario, funcao_funcionario 
FROM funcionarios;

SELECT * FROM vendas;

SELECT data, total_compra 
FROM compras;

SELECT descricao_produto, preco_produto 
FROM produto;

SELECT * FROM filiais;

SELECT nome_produto, quantidade_estoque 
FROM produto;

SELECT * FROM clientesvip 
WHERE pontos_fidelidade > 100;

SELECT * FROM produto 
WHERE preco_produto > 50;

SELECT * FROM funcionarios 
WHERE salario_funcionario > 3000;

SELECT * FROM produto 
WHERE quantidade_estoque < 10;

SELECT * FROM compras 
WHERE data = '2025-01-10';

SELECT * FROM clientesvip 
WHERE telefone_cliente IS NOT NULL;

SELECT * FROM funcionarios 
WHERE funcao_funcionario = 'Caixa';

SELECT * FROM produto 
WHERE id_filial = 1;

SELECT * FROM vendas 
WHERE total_venda > 500;

SELECT * FROM fornecedores 
WHERE nome_fornecedor = 'Distribuidora Alfa';

SELECT * FROM produto 
ORDER BY nome_produto ASC;

SELECT * FROM produto 
ORDER BY preco_produto DESC;

SELECT * FROM clientesvip 
ORDER BY pontos_fidelidade ASC;

SELECT * FROM funcionarios 
ORDER BY salario_funcionario DESC;

SELECT * FROM vendas 
ORDER BY data DESC;

SELECT * FROM compras 
ORDER BY total_compra DESC;

SELECT * FROM produto 
ORDER BY quantidade_estoque ASC;

SELECT * FROM fornecedores 
ORDER BY nome_fornecedor ASC;

SELECT * FROM filiais 
ORDER BY endereco_filial ASC;

SELECT * FROM funcionarios
ORDER BY funcao_funcionario ASC, nome_funcionario ASC;

SELECT * FROM produto 
ORDER BY id_categoria ASC, preco_produto DESC;

SELECT id_categoria, COUNT(*) AS quantidade_produtos 
FROM produto 
GROUP BY id_categoria;

SELECT id_filial, SUM(total_venda) AS total_vendas 
FROM vendas 
GROUP BY id_filial;

SELECT id_filial, COUNT(*) AS quantidade_funcionarios 
FROM funcionarios 
GROUP BY id_filial;

SELECT id_fornecedor, SUM(total_compra) AS total_compras 
FROM compras 
GROUP BY id_fornecedor;

SELECT funcao_funcionario, AVG(salario_funcionario) AS media_salarial 
FROM funcionarios 
GROUP BY funcao_funcionario;

SELECT id_funcionario, COUNT(*) AS quantidade_vendas 
FROM vendas 
GROUP BY id_funcionario;

SELECT id_fornecedor, COUNT(*) AS quantidade_produtos 
FROM produto 
GROUP BY id_fornecedor;

SELECT endereco_cliente, SUM(pontos_fidelidade) AS total_pontos 
FROM clientesvip 
GROUP BY endereco_cliente;

SELECT id_filial, COUNT(*) AS quantidade_compras 
FROM compras 
GROUP BY id_filial;

SELECT id_categoria, SUM(quantidade_estoque) AS estoque_total 
FROM produto 
GROUP BY id_categoria;

SELECT funcao_funcionario, MAX(salario_funcionario) AS maior_salario 
FROM funcionarios 
GROUP BY funcao_funcionario;

SELECT id_categoria, COUNT(*) AS quantidade_produtos 
FROM produto 
GROUP BY id_categoria 
HAVING COUNT(*) > 5;

SELECT id_filial, SUM(total_venda) AS total_vendas 
FROM vendas 
GROUP BY id_filial 
HAVING SUM(total_venda) > 10000;

SELECT funcao_funcionario, AVG(salario_funcionario) AS media_salarial 
FROM funcionarios 
GROUP BY funcao_funcionario 
HAVING AVG(salario_funcionario) > 3000;

SELECT id_fornecedor, COUNT(*) AS quantidade_produtos 
FROM produto 
GROUP BY id_fornecedor 
HAVING COUNT(*) > 10;

SELECT id_funcionario, COUNT(*) AS quantidade_vendas 
FROM vendas 
GROUP BY id_funcionario 
HAVING COUNT(*) > 20;

SELECT id_filial, COUNT(*) AS quantidade_funcionarios 
FROM funcionarios 
GROUP BY id_filial 
HAVING COUNT(*) > 3;

SELECT id_categoria, SUM(quantidade_estoque) AS estoque_total 
FROM produto 
GROUP BY id_categoria 
HAVING SUM(quantidade_estoque) > 500;

SELECT id_fornecedor, SUM(total_compra) AS total_compras 
FROM compras 
GROUP BY id_fornecedor 
HAVING SUM(total_compra) > 5000;

SELECT data, COUNT(*) AS quantidade_vendas 
FROM vendas 
GROUP BY data 
HAVING COUNT(*) > 10;

SELECT endereco_cliente, SUM(pontos_fidelidade) AS soma_pontos 
FROM clientesvip 
GROUP BY endereco_cliente 
HAVING SUM(pontos_fidelidade) > 200;

SELECT funcao_funcionario, MAX(salario_funcionario) AS maior_salario 
FROM funcionarios 
GROUP BY funcao_funcionario 
HAVING MAX(salario_funcionario) > 7000;

SELECT P.nome_produto, C.nome_categoria 
FROM produto P 
JOIN categorias C ON P.id_categoria = C.id_categoria;

SELECT P.nome_produto, F.nome_fornecedor 
FROM produto P
JOIN fornecedores F 
ON P.id_fornecedor = F.id_fornecedor;

SELECT Func.nome_funcionario, Fil.nome_filial 
FROM funcionarios Func 
JOIN filiais Fil 
ON Func.id_filial = Fil.id_filial;

SELECT V.id_venda, V.data, C.nome_cliente 
FROM vendas V 
JOIN clientesvip C 
ON V.id_cliente = C.id_cliente;

SELECT Com.id_compra, Com.data, F.nome_fornecedor 
FROM compras Com  
JOIN fornecedores F 
ON Com.id_fornecedor = F.id_fornecedor;

SELECT IV.id_venda, P.nome_produto, IV.quantidade_venda, IV.total_venda 
FROM itensvenda IV 
JOIN produto P 
ON IV.id_produto = P.id_produto;

SELECT P.nome_produto, F.nome_filial 
FROM produto P 
JOIN filiais F 
ON P.id_filial = F.id_filial;

SELECT V.id_venda, F.nome_funcionario 
FROM vendas V 
JOIN funcionarios F 
ON V.id_funcionario = F.id_funcionario;

SELECT C.id_compra, F.nome_filial, C.total_compra 
FROM compras CJOIN filiais F 
ON C.id_filial = F.id_filial;

SELECT C.nome_cliente, V.id_venda, V.total_venda 
FROM clientesvip C
JOIN vendas V ON C.id_cliente = V.id_cliente;

SELECT V.id_venda, C.nome_cliente, F.nome_funcionario, Fi.nome_filial, V.total_venda 
FROM vendas V 
JOIN clientesvip C ON V.id_cliente = C.id_cliente 
JOIN funcionarios F ON V.id_funcionario = F.id_funcionario 
OIN filiais Fi ON F.id_filial = Fi.id_filial;