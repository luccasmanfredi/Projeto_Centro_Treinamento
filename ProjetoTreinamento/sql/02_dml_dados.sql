-- =====================================================
-- ARQUIVO 02 - DML (Data Manipulation Language)
-- Objetivo: inserir dados de exemplo do Centro de Treinamento, e testar UPDATE e DELETE
-- Rode DEPOIS do arquivo 01
-- Todos os dados abaixo são inventados (CPFs e telefones fictícios)
-- =====================================================

USE gestao_escolar;

-- Passo 1: inserir na tabela gestao (id_gestao 1 a 4)
INSERT INTO gestao (nome_responsavel, cpf_responsavel, valor_mensalidade, matricula_aluno) VALUES
('Marcos Silva','111.222.333-44', 350.00, 'RG, CPF, comprovante de residência, histórico escolar'),
('Patrícia Souza','222.333.444-55', 420.50, 'RG, CPF, comprovante de residência'),
('Roberto Lima','333.444.555-66', 300.00, 'RG, CPF, certidão de nascimento, histórico escolar'),
('Fernanda Costa','444.555.666-77', 450.00, 'RG, CPF, comprovante de residência, foto 3x4');

-- Passo 2: inserir na tabela cursos (id_cursos 1 a 4)
INSERT INTO cursos (nome_curso, categoria_curso, carga_horaria_curso, descricao_curso, status_cursos) VALUES
('Informática Básica','Tecnologia', 60,  'Introdução ao uso do computador, Word, Excel e internet.', 'Ativo'),
('Programação Web','Tecnologia', 120, 'Criação de sites com HTML, CSS e JavaScript.','Em curso'),
('Inglês Intermediário','Idiomas', 80,  'Conversação, leitura e gramática do nível intermediário.','Ativo'),
('Robótica','Tecnologia', 100, 'Montagem e programação de pequenos robôs.','Concluído');

-- Passo 3: inserir na tabela instrutores (id_instrutores 1 a 4)
INSERT INTO instrutores (nome_instrutor, cpf_instrutor, telefone_instrutor, cargo, carga_horaria_instrutor, frequencia_trabalhados_por_semana) VALUES
('Carlos Eduardo Mendes','555.666.777-88', '(11) 91111-1111', 'Professor Titular', 40, 'Segunda a Sexta'),
('Juliana Alves','666.777.888-99', '(11) 92222-2222', 'Coordenador',30, 'Segunda, Quarta e Sexta'),
('Lucas Ferreira','777.888.999-00', '(11) 93333-3333', 'Monitor',20, 'Terça e Quinta'),
('Ana Beatriz Rocha','888.999.000-11', '(11) 94444-4444', 'Professor Titular', 36, 'Segunda a Quinta');

-- Passo 4: inserir na tabela alunos (id_aluno 1 a 8)
-- O último valor (id_gestao) é a FK: qual responsável cuida de cada aluno
INSERT INTO alunos (nome_aluno, cpf_aluno, email_aluno, telefone_aluno, idade_aluno, ano_escolar, id_gestao) VALUES
('Pedro Henrique Silva','100.200.300-01', 'pedro.silva@email.com',   '(11) 95555-0001', 16, '2º ano EM', 1),
('Mariana Silva','100.200.300-02', 'mariana.silva@email.com', '(11) 95555-0002', 14, '9º ano EF', 1),
('Gabriel Souza','100.200.300-03', 'gabriel.souza@email.com', '(11) 95555-0003', 15, '1º ano EM', 2),
('Larissa Lima','100.200.300-04', 'larissa.lima@email.com',  '(11) 95555-0004', 17, '3º ano EM', 3),
('Rafael Costa','100.200.300-05', 'rafael.costa@email.com',  '(11) 95555-0005', 16, '2º ano EM', 4),
('Beatriz Costa','100.200.300-06', 'beatriz.costa@email.com', '(11) 95555-0006', 13, '8º ano EF', 4),
('Thiago Lima','100.200.300-07', 'thiago.lima@email.com',   '(11) 95555-0007', 15, '1º ano EM', 3),
('Camila Souza','100.200.300-08', 'camila.souza@email.com',  '(11) 95555-0008', 16, '2º ano EM', 2);

-- Passo 5: inserir na tabela turmas (id_turma 1 a 5)
-- Os dois últimos valores são as FKs: id_cursos e id_instrutores
INSERT INTO turmas (nome_turma, turno, sala, horario_inicio_aula, frequencia_por_semana, quantidade_vagas, ano_conclusao, id_cursos, id_instrutores) VALUES
('INFO-A', 'Manhã', 'Sala 01', '08:00:00', 'Segunda e Quarta', 20, 2026, 1, 3),
('WEB-A', 'Tarde', 'Lab 02', '14:00:00', 'Terça e Quinta', 15, 2027, 2, 1),
('ING-A', 'Noite', 'Sala 03', '19:00:00', 'Segunda e Quarta', 25, 2026, 3, 4),
('WEB-B', 'Noite', 'Lab 02', '19:30:00', 'Terça e Quinta', 15, 2027, 2, 1),
('ROB-A', 'Manhã', 'Lab 01', '09:00:00', 'Sexta', 10, 2025, 4, 2);

-- Passo 6: inserir na tabela alunos_turmas (quem está em qual turma)
INSERT INTO alunos_turmas (id_aluno, id_turma, data_inscricao) VALUES
(1, 2,'2026-02-01'),
(1, 3,'2026-02-01'),
(2, 1,'2026-02-03'),
(3, 2,'2026-02-05'),
(3, 3,'2026-02-05'),
(4, 2,'2026-02-07'),
(4, 4,'2026-02-07'),
(5, 5,'2026-02-10'),
(6, 1,'2026-02-10'),
(7, 3,'2026-02-12'),
(8, 2,'2026-02-15'),
(8, 4,'2026-02-15');

-- Passo 7: UPDATE - exemplos de atualização
-- Corrigir o telefone de uma aluna
UPDATE alunos
SET telefone_aluno = '(11) 96666-0002'
WHERE id_aluno = 2;

-- Dar reajuste de 10% na mensalidade da gestão número 3
UPDATE gestao
SET valor_mensalidade = valor_mensalidade * 1.10
WHERE id_gestao = 3;

-- Passo 8: DELETE - exemplo de exclusão
-- Remove a inscrição do aluno 7 na turma 3 (a tabela associativa não é pai de ninguém, então é seguro)
DELETE FROM alunos_turmas
WHERE id_aluno = 7 AND id_turma = 3;

-- -----------------------------------------------------------------------------------------------------------------
SELECT * FROM gestao;
SELECT * FROM cursos;
SELECT * FROM instrutores;
SELECT * FROM alunos;
SELECT * FROM turmas;
SELECT * FROM alunos_turmas;
