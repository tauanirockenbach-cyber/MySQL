-- escola db
CREATE DATABASE EscolaDB;
USE EscolaDB;

CREATE TABLE Alunos (
    id_aluno INT PRIMARY KEY AUTO_INCREMENT,
    nome_aluno VARCHAR(100),
    cidade_aluno VARCHAR(100),
    idade_aluno INT
);

CREATE TABLE Cursos (
    id_curso INT PRIMARY KEY AUTO_INCREMENT,
    nome_curso VARCHAR(100),
    carga_horaria INT
);

CREATE TABLE Matriculas (
    id_matricula INT PRIMARY KEY AUTO_INCREMENT,
    id_aluno INT,
    id_curso INT,
    nota_aluno DECIMAL(4,2),
    faltas_aluno INT,
FOREIGN KEY (id_aluno)REFERENCES Alunos(id_aluno),
FOREIGN KEY (id_curso)REFERENCES Cursos(id_curso)
);

INSERT INTO Alunos (nome_aluno, cidade_aluno, idade_aluno)VALUES
('Carlos','São Paulo',18),
('Mariana','Curitiba',22),
('João','Florianópolis',19),
('Fernanda','São Paulo',25),
('Lucas','Rio de Janeiro',20),
('Patricia','Curitiba',21),
('Ana','Porto Alegre',23),
('Bruno','São Paulo',24);

INSERT INTO Cursos (nome_curso, carga_horaria)VALUES
('Python',40),
('Banco de Dados',60),
('Java',80),
('Data Science',100);

INSERT INTO Matriculas (id_aluno, id_curso, nota_aluno, faltas_aluno)VALUES
(1,1,8.5,2),
(1,2,7.0,5),
(2,1,9.5,1),
(2,4,8.0,4),
(3,2,6.5,6),
(3,3,7.5,3),
(4,4,9.0,0),
(5,1,5.5,10),
(5,2,6.0,7),
(6,3,8.5,2),
(7,4,7.0,5),
(8,2,9.5,1);

SELECT * FROM Alunos;

-- Liste todos os alunos cadastrados.
SELECT id_aluno, nome_aluno
FROM Alunos;

-- Liste apenas os nomes dos alunos.
SELECT nome_aluno
FROM Alunos;

-- Exiba todos os cursos cadastrados.
SELECT nome_curso
FROM Cursos;

-- Mostre os alunos que moram em São Paulo.
SELECT nome_aluno
FROM Alunos
WHERE cidade_aluno = 'São Paulo';

-- Liste os alunos com idade maior que 20 anos.
SELECT nome_aluno
FROM Alunos
WHERE idade_aluno > 20;

-- Exiba os cursos com carga horária maior que 50 horas.
SELECT nome_curso
FROM Cursos
WHERE carga_horaria > 50;

-- 7. Mostre os alunos com idade entre 18 e 22 anos.
SELECT nome_aluno
FROM Alunos
WHERE idade_aluno > 18 and idade_aluno < 22;

-- 8. Liste os alunos da cidade de Curitiba.
SELECT nome_aluno
FROM Alunos
WHERE cidade_aluno = 'Curitiba';

-- 9. Exiba os alunos cuja idade seja menor que 21 anos.
SELECT nome_aluno
FROM Alunos
WHERE idade_aluno < 21;

-- 10. Liste todas as matrículas cadastradas.
SELECT id_matricula
FROM Matriculas;


-- Intermediárias


-- 1. Mostre os alunos que possuem nota maior que 8.
SELECT nome_aluno, nota_aluno
FROM Alunos, Matriculas
WHERE nota_aluno > 8;

--2. Liste os alunos que tiveram mais de 5 faltas.
SELECT nome_aluno, faltas_aluno
FROM Alunos, Matriculas
WHERE faltas_aluno > 5;

--3. Exiba os cursos com carga horária igual a 80 horas.
SELECT nome_curso
FROM Cursos
WHERE carga_horaria = 80;

--4. Mostre os alunos que NÃO moram em São Paulo.
SELECT nome_aluno
FROM Alunos
WHERE cidade_aluno != 'São Paulo';

--5. Liste os alunos cujo nome começa com a letra “A”.
SELECT nome_aluno
FROM Alunos
WHERE nome_aluno  LIKE 'A%';

--6. Exiba os alunos cujo nome termina com a letra “a”.
SELECT nome_aluno
FROM Alunos
WHERE nome_aluno  LIKE '%a';

--7. Liste os cursos cujo nome contenha a palavra “Dados”.
SELECT nome_curso
FROM Cursos
WHERE nome_curso  LIKE '%Dados%';

--8. Mostre as matrículas com nota entre 7 e 9.
SELECT id_matricula
FROM Matriculas
WHERE nota_aluno >= 7 and nota_aluno <= 9;

--9. Liste os alunos que possuem exatamente 20 anos.
SELECT nome_aluno
FROM Alunos
WHERE idade_aluno = 20;

--10. Exiba os cursos com carga horária menor ou igual a 60 horas.
SELECT nome_curso
FROM Cursos
WHERE carga_horaria <= 60;

-- Questões com GROUP BY

-- 1. Mostre quantos alunos existem em cada cidade.
SELECT cidade_aluno, COUNT (cidade_aluno)
FROM Alunos
GROUP BY cidade_aluno;

-- 2. Exiba a média de idade dos alunos agrupada por cidade.
SELECT cidade_aluno, AVG (idade_aluno)
FROM Alunos
GROUP BY cidade_aluno;

-- 3. Mostre a quantidade de matrículas por curso.
SELECT id_curso, COUNT(id_curso)
from Matriculas
GROUP BY id_curso;

-- 4. Exiba a média das notas por curso.
SELECT nome_curso, AVG (nota_aluno) as media
FROM Cursos
JOIN Matriculas
ON Cursos .id_curso = Matriculas .id_curso
GROUP BY nome_curso;

-- 5. Mostre o total de faltas agrupado por curso.
SELECT nome_curso, sum (faltas_aluno) as total_falta
FROM Matriculas
JOIN Cursos
ON Cursos .id_curso = Matriculas .id_curso
GROUP BY nome_curso;

-- 6. Liste a maior nota obtida em cada curso.

select nome_curso, max (nota_aluno)
from Matriculas
JOIN Cursos
ON Cursos .id_curso = Matriculas .id_curso
GROUP BY nome_curso;

-- 7. Exiba a menor nota registrada em cada curso.
select nome_curso, min (nota_aluno)
from Matriculas
JOIN Cursos
ON Cursos .id_curso = Matriculas .id_curso
GROUP BY nome_curso;

-- 8. Mostre a soma total das faltas agrupadas por aluno.
SELECT nome_aluno, sum (faltas_aluno) as total_falta
FROM Matriculas
JOIN Alunos
ON Alunos .id_aluno = Matriculas .id_aluno
GROUP BY nome_aluno
ORDER BY nome_aluno;

-- 9. Exiba a média de notas agrupada por aluno.
SELECT nome_aluno, AVG (nota_aluno) as total_nota
FROM Matriculas
JOIN Alunos
ON Alunos .id_aluno = Matriculas .id_aluno
GROUP BY nome_aluno
ORDER BY nome_aluno;

-- 10. Mostre quantos alunos existem em cada faixa etária.
SELECT idade_aluno, COUNT(*) AS quant_alunos 
FROM Alunos
GROUP BY idade_aluno
ORDER BY idade_aluno;

# Questões Avançadas — HAVING e ORDER BY

#  1. Liste as cidades que possuem mais de 2 alunos.
SELECT cidade_aluno, COUNT(cidade_aluno) as cidade
FROM Alunos
GROUP BY cidade_aluno
HAVING(cidade > 2);

# 2. Exiba os cursos cuja média de notas seja maior que 8.
SELECT nome_curso, avg (nota_aluno) as nota
FROM Matriculas
JOIN Cursos
ON Matriculas .id_curso = Cursos .id_curso
GROUP BY nota_aluno, nome_curso
HAVING(nota > 8);

# 3. Mostre os cursos que possuem mais de 2 matrículas.
SELECT nome_curso, COUNT(nome_curso) as curso
FROM Matriculas
join Cursos
ON Matriculas .id_curso = Cursos .id_curso
GROUP BY nome_curso
HAVING(curso > 2);

# 4. Liste os alunos cuja soma de faltas seja maior que 5.
SELECT nome_aluno, sum (faltas_aluno) as total_falta
FROM Matriculas
JOIN Alunos
ON Alunos .id_aluno = Matriculas .id_aluno
GROUP BY nome_aluno
HAVING(total_falta > 5);

# 5. Exiba os cursos cuja menor nota seja maior que 6.
select nome_curso, min (nota_aluno) as nota
from Matriculas
JOIN Cursos
ON Cursos .id_curso = Matriculas .id_curso
GROUP BY nome_curso
HAVING(nota > 6);

# 6. Mostre os cursos ordenados pela carga horária em ordem decrescente.
select nome_curso, carga_horaria
from Cursos
ORDER BY carga_horaria DESC;

# 7. Liste os alunos ordenados por idade do maior para o menor.
select nome_aluno, idade_aluno
from Alunos
ORDER BY  idade_aluno DESC;

# 8. Exiba a média de notas por curso ordenada da maior para a menor.
SELECT nome_curso, AVG (nota_aluno) as media
FROM Cursos
JOIN Matriculas
ON Cursos .id_curso = Matriculas .id_curso
GROUP BY nome_curso
ORDER BY media desc;

# 9. Mostre as cidades ordenadas pela quantidade de alunos.
SELECT cidade_aluno, COUNT(nome_aluno) as quant
FROM Alunos
GROUP BY cidade_aluno;

# 10. Liste os alunos com média de notas maior que 7 ordenados pela média decrescente.
SELECT nome_aluno, avg (nota_aluno) as nota
FROM Alunos
JOIN Matriculas
ON Matriculas .id_aluno = Alunos .id_aluno
GROUP BY nota_aluno, nome_aluno
HAVING (nota > 7)
ORDER BY nota DESC;