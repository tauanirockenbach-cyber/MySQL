-- 1. CRIAR E SELECIONAR O BANCO DE DADOS
CREATE DATABASE hp;
USE hp;

-- 2. CRIAR TABELAS FALTANTES
CREATE TABLE Medicos (
    id_medico INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    especialidade VARCHAR(50) NOT NULL
);

CREATE TABLE Pacientes (
    id_paciente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE NOT NULL
);

-- 3. CRIAR A TABELA DE CONSULTAS (CORRIGIDA)
CREATE TABLE Consultas (
    id_consulta INT AUTO_INCREMENT PRIMARY KEY,
    id_paciente INT NOT NULL,
    id_medico INT NOT NULL, -- Coluna adicionada para corrigir o seu SELECT
    data_consulta DATE NOT NULL,
    valor DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_paciente) REFERENCES Pacientes(id_paciente),
    FOREIGN KEY (id_medico) REFERENCES Medicos(id_medico)
);

-- 4. POPULAR TABELAS DE APOIO
INSERT INTO Medicos (nome, especialidade) VALUES
('Dr. Silva', 'Cardiologia'),
('Dra. Maria', 'Pediatria'),
('Dr. Roberto', 'Clínica Geral');

INSERT INTO Pacientes (nome, data_nascimento) VALUES
('Carlos Souza', '1985-05-12'),
('Ana Costa', '1990-08-22'),
('Bruno Lima', '2015-03-10'),
('Mariana Dias', '1978-11-04');

-- 5. POPULAR TABELA DE CONSULTAS (COM ID_MEDICO)
-- Note que o Dr. Silva (id_medico = 1) terá 6 consultas para testar o seu HAVING > 5
INSERT INTO Consultas (id_paciente, id_medico, data_consulta, valor) VALUES
(1, 1, '2026-01-10', 150.00),
(1, 1, '2026-02-15', 200.00),
(2, 1, '2026-01-12', 120.00),
(3, 2, '2026-03-01', 350.00),
(2, 1, '2026-03-05', 120.00),
(4, 1, '2026-04-18', 250.00),
(1, 1, '2026-05-20', 180.00),
(3, 3, '2026-05-21', 150.00);


select id_paciente as paciente,
 data_consulta as data,
sum (valor) as total_diario
from Consultas
GROUP BY id_paciente, data_consulta;

SELECT id_paciente,
sum (valor)
from Consultas
where valor>200
group by id_paciente;

select id_paciente,
sum (valor) as total
from Consultas
GROUP BY id_paciente
having sum(valor)>100;


SELECT id_medico, COUNT(*) AS TotalConsultas
FROM Consultas
GROUP BY id_medico
HAVING COUNT(*)>5;