use EscolaDB;

#1 Liste os alunos que possuem a maior idade cadastrada.
select nome_aluno, idade_aluno
from Alunos
WHERE idade_aluno = (SELECT MAX(idade_aluno) FROM Alunos);

#2 Exiba os alunos que possuem idade menor que a média das idades.
select nome_aluno, idade_aluno
from Alunos
WHERE idade_aluno < (SELECT AVG(idade_aluno) FROM Alunos);

#3 Mostre os cursos que possuem a maior carga horária.
select nome_curso, carga_horaria
from Cursos
WHERE carga_horaria = (SELECT MAX(carga_horaria) FROM Cursos);

#4 Liste os alunos que possuem nota igual à maior nota registrada nas matrículas.
SELECT Alunos.nome_aluno, Matriculas.nota_aluno 
FROM Matriculas
JOIN Alunos ON Matriculas.id_aluno = Alunos.id_aluno 
WHERE Matriculas.nota_aluno = (SELECT MAX(nota_aluno) FROM Matriculas);

#5 Exiba os alunos que possuem nota menor que a média geral das notas.
SELECT Alunos.nome_aluno, Matriculas.nota_aluno 
FROM Alunos
JOIN Matriculas ON Alunos.id_aluno = Matriculas.id_aluno
WHERE Matriculas.nota_aluno < (SELECT AVG(nota_aluno) FROM Matriculas); 

#6 Mostre os cursos cuja carga horária seja maior que a média das cargas horárias.
select nome_curso, carga_horaria
from Cursos
WHERE carga_horaria > (SELECT AVG(carga_horaria) FROM Cursos);

#7 Liste os alunos que possuem exatamente a menor idade cadastrada.
select nome_aluno, idade_aluno
from Alunos
WHERE idade_aluno = (SELECT MIN(idade_aluno) FROM Alunos);

#8 Exiba as matrículas cuja quantidade de faltas seja maior que a média de faltas.
SELECT Alunos.nome_aluno, Matriculas.faltas_aluno
FROM Matriculas
JOIN Alunos ON Matriculas.id_aluno = Alunos.id_aluno
WHERE Matriculas.faltas_aluno > (SELECT AVG(faltas_aluno) FROM Matriculas);

#9 Mostre os cursos que possuem carga horária diferente da maior carga horária.
SELECT nome_curso, carga_horaria 
FROM Cursos 
WHERE carga_horaria <> (SELECT MAX(carga_horaria) FROM Cursos);

#10 Liste os alunos que possuem nota igual à menor nota registrada.
SELECT Alunos.nome_aluno, Matriculas.nota_aluno 
FROM Matriculas 
JOIN Alunos ON Matriculas.id_aluno = Alunos.id_aluno 
WHERE Matriculas.nota_aluno = (SELECT MIN(nota_aluno) FROM Matriculas);

#1 Liste os nomes dos alunos que possuem matrícula cadastrada.
SELECT Alunos.nome_aluno 
FROM Alunos
JOIN Matriculas ON Alunos.id_aluno = Matriculas.id_aluno;

#2 Exiba os cursos que possuem alunos matriculados.
SELECT Cursos.nome_curso 
FROM Cursos
JOIN Matriculas ON Cursos.id_curso = Matriculas.id_curso;

#3 Mostre os alunos que estão matriculados no curso “Python”.
SELECT Alunos.nome_aluno 
FROM Alunos
JOIN Matriculas ON Alunos.id_aluno = Matriculas.id_aluno
JOIN Cursos ON Matriculas.id_curso = Cursos.id_curso
WHERE Cursos.nome_curso = 'Python';

#4 Liste os alunos matriculados em cursos com carga horária maior que 60 horas.
SELECT Alunos.nome_aluno 
FROM Alunos
JOIN Matriculas ON Alunos.id_aluno = Matriculas.id_aluno
JOIN Cursos ON Matriculas.id_curso = Cursos.id_curso
WHERE Cursos.carga_horaria > 60;

#5 Exiba os cursos nos quais existem alunos com nota maior que 8.
SELECT Cursos.nome_curso 
FROM Cursos
JOIN Matriculas ON Cursos.id_curso = Matriculas.id_curso
WHERE Matriculas.nota_aluno > 8;

#6 Mostre os alunos que possuem mais de uma matrícula.
SELECT Alunos.nome_aluno, COUNT(Matriculas.id_matricula) AS total_matriculas
FROM Alunos
JOIN Matriculas ON Alunos.id_aluno = Matriculas.id_aluno
GROUP BY Alunos.id_aluno, Alunos.nome_aluno
HAVING COUNT(Matriculas.id_matricula) > 1;

#7 Liste os cursos que NÃO possuem matrículas cadastradas.
SELECT Cursos.nome_curso 
FROM Cursos
JOIN Matriculas ON Cursos.id_curso = Matriculas.id_curso
WHERE Matriculas.id_matricula IS NULL;

#8 Exiba os alunos que possuem faltas maiores que 5 em alguma matrícula.
SELECT Alunos.nome_aluno, Matriculas.faltas_aluno
FROM Alunos
JOIN Matriculas ON Alunos.id_aluno = Matriculas.id_aluno
WHERE Matriculas.faltas_aluno > 5
ORDER BY faltas_aluno;

#9 Mostre os cursos frequentados por alunos da cidade de Curitiba.
SELECT Cursos.nome_curso 
FROM Cursos
JOIN Matriculas ON Cursos.id_curso = Matriculas.id_curso
JOIN Alunos ON Matriculas.id_aluno = Alunos.id_aluno
WHERE Alunos.cidade_aluno = 'Curitiba';

#10 Liste os alunos matriculados no curso com maior carga horária.
SELECT Alunos.nome_aluno, Cursos.nome_curso, Cursos.carga_horaria
FROM Alunos
JOIN Matriculas ON Alunos.id_aluno = Matriculas.id_aluno
JOIN Cursos ON Matriculas.id_curso = Cursos.id_curso
WHERE Cursos.carga_horaria = (SELECT MAX(carga_horaria) FROM Cursos);

#1 Exiba os alunos cuja idade seja maior que a média de idade dos alunos de São Paulo.
SELECT nome_aluno, idade_aluno 
FROM Alunos 
WHERE idade_aluno > (SELECT AVG(idade_aluno) FROM Alunos WHERE cidade_aluno = 'São Paulo');

#2 Liste os cursos cuja média de notas seja maior que a média geral das notas.
SELECT Cursos.nome_curso, AVG(Matriculas.nota_aluno) AS media_curso
FROM Cursos
JOIN Matriculas ON Cursos.id_curso = Matriculas.id_curso
GROUP BY Cursos.id_curso, Cursos.nome_curso
HAVING AVG(Matriculas.nota_aluno) > (SELECT AVG(nota_aluno) FROM Matriculas);

#3 Mostre os alunos cuja soma de faltas seja maior que a média total de faltas.
SELECT Alunos.nome_aluno, SUM(Matriculas.faltas_aluno) AS total_faltas_aluno
FROM Alunos
JOIN Matriculas ON Alunos.id_aluno = Matriculas.id_aluno
GROUP BY Alunos.id_aluno, Alunos.nome_aluno
HAVING SUM(Matriculas.faltas_aluno) > (SELECT AVG(faltas_aluno) FROM Matriculas);

#4 Exiba os cursos cuja maior nota registrada seja igual à maior nota do sistema.
SELECT Cursos.nome_curso
FROM Cursos
JOIN Matriculas ON Cursos.id_curso = Matriculas.id_curso
GROUP BY Cursos.id_curso, Cursos.nome_curso
HAVING MAX(Matriculas.nota_aluno) = (SELECT MAX(nota_aluno) FROM Matriculas);

#5 Liste os alunos cuja média de notas seja menor que a média geral dos alunos.
SELECT Alunos.nome_aluno, AVG(Matriculas.nota_aluno) AS media_aluno
FROM Alunos
JOIN Matriculas ON Alunos.id_aluno = Matriculas.id_aluno
GROUP BY Alunos.id_aluno, Alunos.nome_aluno
HAVING AVG(Matriculas.nota_aluno) < (SELECT AVG(nota_aluno) FROM Matriculas);

#6 Mostre os cursos cuja quantidade de matrículas seja maior que a média de matrículas dos cursos.
SELECT Cursos.nome_curso, COUNT(Matriculas.id_matricula) AS total_matriculas
FROM Cursos
JOIN Matriculas ON Cursos.id_curso = Matriculas.id_curso
GROUP BY Cursos.id_curso, Cursos.nome_curso
HAVING COUNT(Matriculas.id_matricula) > (
SELECT AVG(total) FROM (
SELECT COUNT(id_matricula) AS total FROM Matriculas GROUP BY id_curso) AS sub_medias);

#7 Exiba os alunos que possuem nota maior que todas as notas do curso “Banco de Dados”.
SELECT DISTINCT Alunos.nome_aluno, Matriculas.nota_aluno
FROM Alunos
JOIN Matriculas ON Alunos.id_aluno = Matriculas.id_aluno
WHERE Matriculas.nota_aluno > ALL (
SELECT M.nota_aluno 
FROM Matriculas M
JOIN Cursos C ON M.id_curso = C.id_curso
WHERE C.nome_curso = 'Banco de Dados');

#8 Liste os cursos cuja menor nota seja maior que a média geral das menores notas dos cursos.
SELECT Cursos.nome_curso, MIN(Matriculas.nota_aluno) AS menor_nota_curso
FROM Cursos
JOIN Matriculas ON Cursos.id_curso = Matriculas.id_curso
GROUP BY Cursos.id_curso, Cursos.nome_curso
HAVING MIN(Matriculas.nota_aluno) > (
SELECT AVG(menor_nota) FROM (
SELECT MIN(nota_aluno) AS menor_nota FROM Matriculas GROUP BY id_curso) AS sub_menores
);

#9 Mostre os alunos cuja idade seja igual à idade média dos alunos.
SELECT nome_aluno, idade_aluno 
FROM Alunos 
WHERE idade_aluno = (SELECT AVG(idade_aluno) FROM Alunos);

#10 Exiba os cursos cuja carga horária seja menor que a maior carga horária cadastrada.
SELECT nome_curso, carga_horaria 
FROM Cursos 
WHERE carga_horaria < (SELECT MAX(carga_horaria) FROM Cursos);

#1 Liste os alunos e exiba ao lado a quantidade total de matrículas de cada aluno.
SELECT Alunos.nome_aluno, COUNT(Matriculas.id_matricula) AS total_matriculas
FROM Alunos
JOIN Matriculas ON Alunos.id_aluno = Matriculas.id_aluno
GROUP BY Alunos.id_aluno, Alunos.nome_aluno;

#2 Exiba os cursos e mostre ao lado a média das notas de cada curso.
SELECT Cursos.nome_curso, AVG(Matriculas.nota_aluno) AS media_notas
FROM Cursos
JOIN Matriculas ON Cursos.id_curso = Matriculas.id_curso
GROUP BY Cursos.id_curso, Cursos.nome_curso;

#3 Liste os alunos e mostre a soma total de faltas de cada um.
SELECT Alunos.nome_aluno, SUM(Matriculas.faltas_aluno) AS total_faltas
FROM Alunos
JOIN Matriculas ON Alunos.id_aluno = Matriculas.id_aluno
GROUP BY Alunos.id_aluno, Alunos.nome_aluno;

#4 Exiba os cursos e mostre quantos alunos estão matriculados em cada curso.
SELECT Cursos.nome_curso, COUNT(Matriculas.id_aluno) AS total_alunos
FROM Cursos
JOIN Matriculas ON Cursos.id_curso = Matriculas.id_curso
GROUP BY Cursos.id_curso, Cursos.nome_curso;

#5 Liste os alunos e apresente sua maior nota registrada.
SELECT Alunos.nome_aluno, MAX(Matriculas.nota_aluno) AS maior_nota
FROM Alunos
JOIN Matriculas ON Alunos.id_aluno = Matriculas.id_aluno
GROUP BY Alunos.id_aluno, Alunos.nome_aluno;

#6 Exiba os cursos e mostre a menor nota registrada em cada curso.
SELECT Cursos.nome_curso, MIN(Matriculas.nota_aluno) AS menor_nota
FROM Cursos
JOIN Matriculas ON Cursos.id_curso = Matriculas.id_curso
GROUP BY Cursos.id_curso, Cursos.nome_curso;

#7 Liste os alunos e mostre a média de notas de cada um em uma nova coluna chamada Media_Aluno.
SELECT Alunos.nome_aluno, AVG(Matriculas.nota_aluno) AS Media_Aluno
FROM Alunos
JOIN Matriculas ON Alunos.id_aluno = Matriculas.id_aluno
GROUP BY Alunos.id_aluno, Alunos.nome_aluno;

#8 Exiba os cursos e apresente o total de faltas registradas em cada curso.
SELECT Cursos.nome_curso, SUM(Matriculas.faltas_aluno) AS total_faltas_curso
FROM Cursos
JOIN Matriculas ON Cursos.id_curso = Matriculas.id_curso
GROUP BY Cursos.id_curso, Cursos.nome_curso;

#9 Liste os alunos e mostre a quantidade de cursos diferentes em que estão matriculados.
SELECT Alunos.nome_aluno, COUNT(DISTINCT Matriculas.id_curso) AS quantidade_cursos
FROM Alunos
JOIN Matriculas ON Alunos.id_aluno = Matriculas.id_aluno
GROUP BY Alunos.id_aluno, Alunos.nome_aluno;

#10 Exiba os cursos e mostre a quantidade de alunos aprovados (nota maior ou igual a 7).
SELECT Cursos.nome_curso, SUM(Matriculas.nota_aluno >= 7) AS alunos_aprovados
FROM Cursos
JOIN Matriculas ON Cursos.id_curso = Matriculas.id_curso
GROUP BY Cursos.id_curso, Cursos.nome_curso;

#1 Liste as cidades cuja média de idade seja maior que a média geral de idade dos alunos.
SELECT cidade, AVG(idade_aluno) AS media_idade_cidade
FROM Alunos
GROUP BY cidade
HAVING AVG(idade_aluno) > (SELECT AVG(idade_aluno) FROM Alunos);

#2 Exiba os cursos cuja média de notas seja maior que a média das médias dos cursos.
SELECT Cursos.nome_curso, AVG(Matriculas.nota_aluno) AS media_curso
FROM Cursos
JOIN Matriculas ON Cursos.id_curso = Matriculas.id_curso
GROUP BY Cursos.id_curso, Cursos.nome_curso
HAVING AVG(Matriculas.nota_aluno) > (SELECT AVG(nota_aluno) FROM Matriculas);

#3 Mostre os alunos cuja soma de faltas seja maior que a soma média de faltas dos alunos.
SELECT Alunos.nome_aluno, SUM(Matriculas.faltas_aluno) AS total_faltas_aluno
FROM Alunos
JOIN Matriculas ON Alunos.id_aluno = Matriculas.id_aluno
GROUP BY Alunos.id_aluno, Alunos.nome_aluno
HAVING SUM(Matriculas.faltas_aluno) > (
SELECT AVG(soma_faltas) FROM (
SELECT SUM(faltas_aluno) AS soma_faltas FROM Matriculas GROUP BY id_aluno) AS sub_somas
);

#4 Liste os cursos que possuem quantidade de matrículas acima da média de matrículas por curso.
SELECT Cursos.nome_curso, COUNT(Matriculas.id_matricula) AS total_matriculas
FROM Cursos
JOIN Matriculas ON Cursos.id_curso = Matriculas.id_curso
GROUP BY Cursos.id_curso, Cursos.nome_curso
HAVING COUNT(Matriculas.id_matricula) > (
SELECT AVG(qtd_matriculas) FROM (
SELECT COUNT(id_matricula) AS qtd_matriculas FROM Matriculas GROUP BY id_curso) AS sub_matriculas
);

#5 Exiba os alunos cuja média de notas seja maior que a média dos alunos da cidade de São Paulo.
SELECT Alunos.nome_aluno, AVG(Matriculas.nota_aluno) AS media_individual
FROM Alunos
JOIN Matriculas ON Alunos.id_aluno = Matriculas.id_aluno
GROUP BY Alunos.id_aluno, Alunos.nome_aluno
HAVING AVG(Matriculas.nota_aluno) > (
SELECT AVG(M.nota_aluno) 
FROM Matriculas M
JOIN Alunos A ON M.id_aluno = A.id_aluno
WHERE A.cidade_aluno = 'São Paulo'
);

#6 Mostre os cursos cuja carga horária seja maior que a média das cargas horárias dos cursos com matrícula.
SELECT nome_curso, carga_horaria
FROM Cursos
WHERE carga_horaria > (
SELECT AVG(carga_horaria) 
FROM Cursos 
WHERE id_curso IN (SELECT id_curso FROM Matriculas)
);

#7 Liste os alunos que possuem mais matrículas que a média de matrículas dos alunos.
SELECT Alunos.nome_aluno, COUNT(Matriculas.id_matricula) AS total_matriculas
FROM Alunos
JOIN Matriculas ON Alunos.id_aluno = Matriculas.id_aluno
GROUP BY Alunos.id_aluno, Alunos.nome_aluno
HAVING COUNT(Matriculas.id_matricula) > (
SELECT AVG(qtd_mat) FROM (
SELECT COUNT(id_matricula) AS qtd_mat FROM Matriculas GROUP BY id_aluno) AS sub_alunos
);

#8 Exiba os cursos cuja maior nota seja inferior à maior nota geral do sistema.
SELECT Cursos.nome_curso, MAX(Matriculas.nota_aluno) AS maior_nota_curso
FROM Cursos
JOIN Matriculas ON Cursos.id_curso = Matriculas.id_curso
GROUP BY Cursos.id_curso, Cursos.nome_curso
HAVING MAX(Matriculas.nota_aluno) < (SELECT MAX(nota_aluno) FROM Matriculas);

#9 Mostre os alunos cuja média de faltas seja menor que a média geral de faltas.
SELECT Alunos.nome_aluno, AVG(Matriculas.faltas_aluno) AS media_faltas_aluno
FROM Alunos
JOIN Matriculas ON Alunos.id_aluno = Matriculas.id_aluno
GROUP BY Alunos.id_aluno, Alunos.nome_aluno
HAVING AVG(Matriculas.faltas_aluno) < (SELECT AVG(faltas_aluno) FROM Matriculas);

#10 Liste os cursos cuja quantidade de alunos aprovados seja maior que a média de aprovados dos cores.
SELECT Cursos.nome_curso, SUM(IF(Matriculas.nota_aluno >= 7, 1, 0)) AS aprovados_curso
FROM Cursos
JOIN Matriculas ON Cursos.id_curso = Matriculas.id_curso
GROUP BY Cursos.id_curso, Cursos.nome_curso
HAVING SUM(IF(Matriculas.nota_aluno >= 7, 1, 0)) > (
SELECT AVG(total_aprovados) FROM (
SELECT SUM(nota_aluno >= 7) AS total_aprovados 
FROM Matriculas 
GROUP BY id_curso) AS sub_aprovados
);
