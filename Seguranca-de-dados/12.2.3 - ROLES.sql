CREATE ROLE'app_desenvolvedor',
'app_leitura',
'app_escrita';

GRANT ALL ON vamosla.*TO'app_desenvolvedor';

GRANT SELECT ON vamosla.*TO'app_leitura';

GRANT INSERT,UPDATE,DELETE ON vamosla.* TO'app_escrita';

CREATE USER'usuario_desenvolvedor'@'localhost';

CREATe USER'usuario_leitura'@'localhost';

CREATE USER'usuario_escrita'@'localhost';

GRANT'app_desenvolvedor'
TO'usuario_desenvolvedor'@'localhost';

GRANT'app_leitura'
TO'usuario_leitura'@'localhost';

GRANT'app_leitura',
'app_escrita'
TO'usuario_escrita'@'localhost';

SET DEFAULT ROLE'app_escrita'
TO'usuario_escrita'@'localhost';

FLUSH PRIVILEGES;

-- 1. Clientes
CREATE TABLE cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    email VARCHAR(100)
);

-- 2. Transporte
CREATE TABLE transporte (
    id_transporte INT PRIMARY KEY AUTO_INCREMENT,
    tipo VARCHAR(50), -- Aéreo, Rodoviário
    valor_transporte DECIMAL(10, 2)
);

-- 3. Hospedagem
CREATE TABLE hospedagem (
    id_hospedagem INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(100),
    valor_diaria DECIMAL(10, 2)
);

-- 4. Pacote (Relaciona transporte e hospedagem)
CREATE TABLE pacote (
    id_pacote INT PRIMARY KEY AUTO_INCREMENT,
    destino VARCHAR(100),
    quantidade_dias INT,
    id_transporte INT,
    id_hospedagem INT,
    FOREIGN KEY (id_transporte) REFERENCES transporte(id_transporte),
    FOREIGN KEY (id_hospedagem) REFERENCES hospedagem(id_hospedagem)
);

-- 5. Venda
CREATE TABLE venda (
    id_venda INT PRIMARY KEY AUTO_INCREMENT,
    data_venda DATE,
    forma_pagamento VARCHAR(50),
    valor_total_dolar DECIMAL(10, 2),
    id_cliente INT,
    id_pacote INT,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_pacote) REFERENCES pacote(id_pacote)
);

INSERT INTO cliente (nome, cpf, email) VALUES 
('Ana Souza', '123.456.789-00', 'ana.souza@email.com'),
('Bruno Costa', '987.654.321-11', 'bruno.costa@email.com'),
('Carla Dias', '456.123.789-22', 'carla.dias@email.com');

INSERT INTO transporte (tipo, valor_transporte) VALUES 
('Aéreo', 650.00),
('Rodoviário', 150.00),
('Aéreo', 800.00);

INSERT INTO hospedagem (descricao, valor_diaria) VALUES 
('Hotel 4 Estrelas - Miami', 120.00),
('Pousada Beira Mar - Florianópolis', 80.00),
('Resort All Inclusive - Cancun', 250.00);

INSERT INTO pacote (destino, quantidade_dias, id_transporte, id_hospedagem) VALUES 
('Miami', 7, 1, 1);

INSERT INTO pacote (destino, quantidade_dias, id_transporte, id_hospedagem) VALUES 
('Florianópolis', 5, 2, 2);

INSERT INTO pacote (destino, quantidade_dias, id_transporte, id_hospedagem) VALUES 
('Cancun', 10, 3, 3);

INSERT INTO venda (data_venda, forma_pagamento, valor_total_dolar, id_cliente, id_pacote) VALUES 
('2026-06-10', 'Cartão de Crédito', 1490.00, 1, 1);

INSERT INTO venda (data_venda, forma_pagamento, valor_total_dolar, id_cliente, id_pacote) VALUES 
('2026-06-12', 'PIX', 550.00, 2, 2);


CREATE ROLE 'app_desativado';
REVOKE 'app_desenvolvedor' FROM 'usuario_desenvolvedor'@'localhost';
GRANT 'app_desativado' TO 'usuario_desenvolvedor'@'localhost';
SET DEFAULT ROLE 'app_desativado' TO 'usuario_desenvolvedor'@'localhost';
FLUSH PRIVILEGES;
SHOW GRANTS FOR 'usuario_desenvolvedor'@'localhost';
SELECT * FROM vamosla.cliente;

SELECT FROM_USER, FROM_HOST, TO_USER, TO_HOST 
FROM mysql.role_edges 
WHERE TO_USER = 'usuario_desenvolvedor';
