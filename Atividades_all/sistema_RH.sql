create database sistemaRH;
use sistemaRH;

create table departamentos(
    id_departamento INT AUTO_INCREMENT PRIMARY KEY,
    nome_departamento VARCHAR(50) NOT NULL UNIQUE
);

create table cargos(
    id_cargo INT AUTO_INCREMENT PRIMARY KEY,
    descricao_cargo VARCHAR(50) NOT NULL UNIQUE
);
CREATE TABLE funcionarios (
    id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    nome_funcionario VARCHAR(100) NOT NULL,
    data_admissao DATE NOT NULL,
    salario_atual DECIMAL(10, 2) NOT NULL,
    id_cargo_atual INT,
    id_departamento_atual INT,
    status_funcionario ENUM('Ativo', 'Desligado') DEFAULT 'Ativo',
    data_desligamento DATE DEFAULT NULL,
    FOREIGN KEY (id_cargo_atual) REFERENCES cargos(id_cargo),
    FOREIGN KEY (id_departamento_atual) REFERENCES departamentos(id_departamento)
);
CREATE TABLE historico_movimentacoes (
    id_movimentacao INT AUTO_INCREMENT PRIMARY KEY,
    id_funcionario INT NOT NULL,
    id_cargo INT NOT NULL,
    id_departamento INT NOT NULL,
    salario_na_epoca DECIMAL(10, 2) NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE DEFAULT NULL, -- Se NULL, significa que era o registro até a última mudança ou atual
    FOREIGN KEY (id_funcionario) REFERENCES funcionarios(id_funcionario) ON DELETE CASCADE,
    FOREIGN KEY (id_cargo) REFERENCES cargos(id_cargo),
    FOREIGN KEY (id_departamento) REFERENCES departamentos(id_departamento)
);

INSERT INTO departamentos (nome_departamento) VALUES 
('Recursos Humanos'),
('Financeiro'),
('TI');

INSERT INTO cargos (descricao_cargo) VALUES 
('Assistente'),
('Analista'),
('Gerente');

INSERT INTO funcionarios (nome_funcionario, data_admissao, salario_atual, id_cargo_atual, id_departamento_atual) 
VALUES ('Vinicius Santos', '2023-01-15', 2200.00, 1, 3),
('Mariana Costa', '2022-03-10', 4500.00, 2, 2),
('Juliana Lopes', '2021-05-20', 8000.00, 3, 1);


INSERT INTO historico_movimentacoes (id_funcionario, id_cargo, id_departamento, salario_na_epoca, data_inicio, data_fim) VALUES
(1, 1, 3, 2500.00, '2023-01-15', '2024-06-01'), 
(2, 2, 2, 4500.00, '2022-03-10', NULL),        
(3, 3, 1, 8000.00, '2021-05-20', NULL);        

UPDATE funcionarios 
SET id_cargo_atual = 2, salario_atual = 4200.00 
WHERE id_funcionario = 1;

INSERT INTO historico_movimentacoes (id_funcionario, id_cargo, id_departamento, salario_na_epoca, data_inicio, data_fim) 
VALUES (1, 2, 3, 4200.00, '2024-06-01', NULL);

-- Consultas:

SELECT f.nome_funcionario, c.descricao_cargo, f.salario_atual 
FROM funcionarios f
JOIN departamentos d ON f.id_departamento_atual = d.id_departamento
JOIN cargos c ON f.id_cargo_atual = c.id_cargo
WHERE d.nome_departamento = 'TI' AND f.status_funcionario = 'Ativo';

SELECT f.nome_funcionario, c.descricao_cargo AS cargo_atual, d.nome_departamento AS departamento_atual, f.salario_atual
FROM funcionarios f
JOIN cargos c ON f.id_cargo_atual = c.id_cargo
JOIN departamentos d ON f.id_departamento_atual = d.id_departamento
WHERE f.status_funcionario = 'Ativo';

SELECT f.nome_funcionario, c.descricao_cargo AS cargo_na_epoca, d.nome_departamento AS depto_na_epoca, 
h.salario_na_epoca, h.data_inicio, IFNULL(h.data_fim, 'Atual') AS data_fim
FROM historico_movimentacoes h
JOIN funcionarios f ON h.id_funcionario = f.id_funcionario
JOIN cargos c ON h.id_cargo = c.id_cargo
JOIN departamentos d ON h.id_departamento = d.id_departamento
WHERE f.nome_funcionario = 'Carlos Silva'
ORDER BY h.data_inicio ASC;

SELECT f.nome_funcionario, COUNT(h.id_movimentacao) AS total_movimentacoes, f.data_admissao
FROM historico_movimentacoes h
INNER JOIN funcionarios f ON h.id_funcionario = f.id_funcionario
GROUP BY f.id_funcionario, f.nome_funcionario, f.data_admissao
HAVING COUNT(h.id_movimentacao) > 1;