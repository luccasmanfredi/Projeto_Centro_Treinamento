-- =====================================================
-- ARQUIVO 03 - DQL (Data Query Language) - Centro de Treinamento
-- Objetivo: consultas (SELECT) para mostrar que o banco funciona
-- Rode DEPOIS dos arquivos 01 e 02
-- =====================================================

USE gestao_escolar;

-- Consulta 1: listar todos os alunos em ordem alfabética
SELECT id_aluno, nome_aluno, idade_aluno, ano_escolar
FROM alunos
ORDER BY nome_aluno;

-- Consulta 2: alunos com 16 anos ou mais (usa WHERE)
SELECT nome_aluno, idade_aluno
FROM alunos
WHERE idade_aluno >= 16;

-- Consulta 3: cursos da categoria Tecnologia que não estão concluídos
SELECT nome_curso, carga_horaria_curso, status_cursos
FROM cursos
WHERE categoria_curso = 'Tecnologia'
  AND status_cursos <> 'Concluído';

-- Consulta 4: cada aluno com o nome do responsável (JOIN alunos + gestao)
SELECT a.nome_aluno,
       g.nome_responsavel,
       g.valor_mensalidade
FROM alunos a
INNER JOIN gestao g ON a.id_gestao = g.id_gestao
ORDER BY a.nome_aluno;

-- Consulta 5: cada turma com o nome do curso e do instrutor (JOIN com 3 tabelas)
SELECT t.nome_turma,
       c.nome_curso,
       i.nome_instrutor,
       t.turno,
       t.horario_inicio_aula
FROM turmas t
INNER JOIN cursos c ON t.id_cursos = c.id_cursos
INNER JOIN instrutores i ON t.id_instrutores = i.id_instrutores
ORDER BY t.nome_turma;

-- Consulta 6: em quais turmas cada aluno está inscrito (usa a tabela N:N)
SELECT a.nome_aluno,
  t.nome_turma,
  c.nome_curso,
  at.data_inscricao
FROM alunos_turmas at
INNER JOIN alunos a ON at.id_aluno = a.id_aluno
INNER JOIN turmas t ON at.id_turma = t.id_turma
INNER JOIN cursos c ON t.id_cursos = c.id_cursos
ORDER BY a.nome_aluno, t.nome_turma;

-- Consulta 7: quantos alunos tem em cada turma (GROUP BY + COUNT)
SELECT t.nome_turma,
  t.quantidade_vagas,
  COUNT(at.id_aluno) AS total_alunos
FROM turmas t
LEFT JOIN alunos_turmas at ON t.id_turma = at.id_turma
GROUP BY t.id_turma, t.nome_turma, t.quantidade_vagas
ORDER BY total_alunos DESC;

-- Consulta 8: vagas que ainda restam em cada turma
SELECT t.nome_turma,
  t.quantidade_vagas - COUNT(at.id_aluno) AS vagas_restantes
FROM turmas t
LEFT JOIN alunos_turmas at ON t.id_turma = at.id_turma
GROUP BY t.id_turma, t.nome_turma, t.quantidade_vagas;

-- Consulta 9: quantas turmas cada instrutor controla
SELECT i.nome_instrutor,
  i.cargo,
  COUNT(t.id_turma) AS total_turmas
FROM instrutores i
LEFT JOIN turmas t ON i.id_instrutores = t.id_instrutores
GROUP BY i.id_instrutores, i.nome_instrutor, i.cargo;

-- Consulta 10: responsáveis que têm mais de 1 aluno matriculado (GROUP BY + HAVING)
SELECT g.nome_responsavel,
  COUNT(a.id_aluno) AS total_alunos
FROM gestao g
INNER JOIN alunos a ON g.id_gestao = a.id_gestao
GROUP BY g.id_gestao, g.nome_responsavel
HAVING COUNT(a.id_aluno) > 1;

-- Consulta 11: média das mensalidades e total arrecadado (funções AVG e SUM)
SELECT AVG(valor_mensalidade) AS media_mensalidade, SUM(valor_mensalidade) AS soma_mensalidades
FROM gestao;

-- Consulta 12: alunos que ainda NÃO estão em nenhuma turma (subconsulta)
SELECT nome_aluno
FROM alunos
WHERE id_aluno NOT IN (SELECT id_aluno FROM alunos_turmas);
