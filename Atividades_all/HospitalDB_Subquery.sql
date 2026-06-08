use HospitalDB;

SELECT nome, cidade 
FROM Hospitais;

SELECT nome, crm, salario 
FROM Medicos;

SELECT nome, tipo_sanguineo 
FROM Pacientes;

SELECT nome, estoque 
FROM Medicamentos 
WHERE estoque > 50;

SELECT nome, alergias 
FROM Pacientes 
WHERE alergias IS NOT NULL AND alergias <> '';

SELECT id_consulta, data_consulta, diagnostico 
FROM Consultas 
WHERE data_consulta > '2025-08-01 10:00:00';

SELECT id_exame, nome, data_exame 
FROM Exames 
WHERE data_exame BETWEEN '2025-08-01' AND '2026-01-31';

SELECT nome, cargo, salario 
FROM Funcionarios 
WHERE salario BETWEEN 2500.00 AND 6000.00;

SELECT numero, tipo, capacidade 
FROM Quartos 
WHERE status_quarto = 'Livre';

SELECT id_pagamento, valor, data_pagamento, forma_pagamento 
FROM Pagamentos 
WHERE forma_pagamento = 'PIX';

SELECT COUNT(*) AS total_pacientes 
FROM Pacientes;

SELECT AVG(valor) AS valor_medio_consultas 
FROM Consultas;

SELECT MIN(valor) AS menor_valor_consulta 
FROM Consultas;

SELECT e.nome AS especialidade, COUNT(m.id_medico) AS quantidade_medicos
FROM Especialidades e
LEFT JOIN Medicos m ON e.id_especialidade = m.id_especialidade
GROUP BY e.id_especialidade, e.nome;

SELECT s.nome AS setor, COUNT(f.id_funcionario) AS quantidade_funcionarios
FROM Setores s
LEFT JOIN Funcionarios f ON s.id_setor = f.id_setor
GROUP BY s.id_setor, s.nome;

SELECT m.nome AS nome_medico, e.nome AS especialidade
FROM Medicos m
INNER JOIN Especialidades e ON m.id_especialidade = e.id_especialidade;

SELECT f.nome AS nome_funcionario, h.nome AS nome_hospital
FROM Funcionarios f
INNER JOIN Hospitais h ON f.id_hospital = h.id_hospital;

SELECT p.nome AS nome_paciente, c.data_consulta
FROM Consultas c
INNER JOIN Pacientes p ON c.id_paciente = p.id_paciente;

SELECT nome, fabricante, preco 
FROM Medicamentos 
WHERE preco = (SELECT MAX(preco) FROM Medicamentos);

SELECT nome, crm, salario 
FROM Medicos 
WHERE salario > (SELECT AVG(salario) FROM Medicos);