-- =====================================================
-- ARQUIVO 04 - TCL (Transaction Control Language) - Centro de Treinamento
-- Objetivo: mostrar o uso de transações (START TRANSACTION, COMMIT, ROLLBACK, SAVEPOINT)
-- Rode DEPOIS dos arquivos 01 e 02
-- =====================================================

USE gestao_escolar;

-- =====================================================
-- Exemplo 1: transação que dá certo (COMMIT)
-- Matricular um aluno novo e já inscrever ele numa turma.
-- As duas ações precisam acontecer juntas: se uma falhar, nenhuma deve valer.
-- =====================================================
START TRANSACTION;

-- Passo 1: cadastrar o aluno novo (responsável 2)
INSERT INTO alunos (nome_aluno, cpf_aluno, email_aluno, telefone_aluno, idade_aluno, ano_escolar, id_gestao)
VALUES ('Vinícius Souza', '100.200.300-09', 'vinicius.souza@email.com', '(11) 95555-0009', 15, '1º ano EM', 2);

-- Passo 2: pegar o id que o AUTO_INCREMENT gerou e inscrever na turma 1
INSERT INTO alunos_turmas (id_aluno, id_turma, data_inscricao)
VALUES (LAST_INSERT_ID(), 1, CURDATE());

-- Passo 3: confirmar tudo
COMMIT;

SELECT * FROM alunos WHERE nome_aluno = 'Vinícius Souza';

-- =====================================================
-- Exemplo 2: transação cancelada (ROLLBACK)
-- Fazemos uma mudança "errada" e desfazemos antes de confirmar.
-- =====================================================
START TRANSACTION;

-- Opa, esse UPDATE foi sem querer e ia zerar todas as mensalidades!
UPDATE gestao SET valor_mensalidade = 0;

-- Conferindo o estrago (ainda dentro da transação)
SELECT id_gestao, valor_mensalidade FROM gestao;

-- Desfaz tudo
ROLLBACK;

-- Conferindo que os valores voltaram ao normal
SELECT id_gestao, valor_mensalidade FROM gestao;

-- =====================================================
-- Exemplo 3: SAVEPOINT (ponto de salvamento)
-- Permite desfazer só uma parte da transação.
-- =====================================================
START TRANSACTION;

-- Primeira alteração: aumentar vagas da turma 1
UPDATE turmas SET quantidade_vagas = quantidade_vagas + 5 WHERE id_turma = 1;

SAVEPOINT depois_das_vagas;

-- Segunda alteração: mudar a sala da turma 1 (vamos desfazer só esta)
UPDATE turmas SET sala = 'Sala 99' WHERE id_turma = 1;

-- Volta só até o savepoint: o aumento de vagas continua, a troca de sala some
ROLLBACK TO depois_das_vagas;

COMMIT;

SELECT id_turma, nome_turma, sala, quantidade_vagas FROM turmas WHERE id_turma = 1;
