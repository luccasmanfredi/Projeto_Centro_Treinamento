USE gestao_escolar;

-- 1. Analisar a busca de alunos por nome (antes do índice)
EXPLAIN SELECT id_aluno, nome_aluno, idade_aluno, ano_escolar
FROM alunos
WHERE nome_aluno = 'Pedro Henrique Silva';

-- Criar índice no nome do aluno para agilizar buscas e ordenações
CREATE INDEX idx_alunos_nome ON alunos(nome_aluno);

-- Testar novamente para ver o uso do índice (campo 'key' no resultado)
EXPLAIN SELECT id_aluno, nome_aluno, idade_aluno, ano_escolar
FROM alunos
WHERE nome_aluno = 'Pedro Henrique Silva';

-- -----------------------------------------------------

-- 2. Analisar o filtro de cursos por categoria e status
EXPLAIN SELECT nome_curso, carga_horaria_curso, status_cursos
FROM cursos
WHERE categoria_curso = 'Tecnologia' AND status_cursos = 'Ativo';

-- Criar índice composto nas duas colunas mais usadas no filtro
CREATE INDEX idx_cursos_categoria_status ON cursos(categoria_curso, status_cursos);

EXPLAIN SELECT nome_curso, carga_horaria_curso, status_cursos
FROM cursos
WHERE categoria_curso = 'Tecnologia' AND status_cursos = 'Ativo';

-- -----------------------------------------------------

-- 3. Analisar a busca de turmas por turno e horário
EXPLAIN SELECT nome_turma, sala, horario_inicio_aula
FROM turmas
WHERE turno = 'Noite';

-- Criar índice no turno das turmas
CREATE INDEX idx_turmas_turno ON turmas(turno);

EXPLAIN SELECT nome_turma, sala, horario_inicio_aula
FROM turmas
WHERE turno = 'Noite';