-- =====================================================
-- ARQUIVO 01 - DDL (Data Definition Language)
-- Projeto: Centro de Treinamento (banco: gestao_escolar)
-- Objetivo: criar o banco de dados do Centro de Treinamento e todas as tabelas
-- Baseado no modelo feito no brModelo
-- =====================================================

-- Passo 1: criar o banco e selecionar ele para uso
CREATE DATABASE IF NOT EXISTS gestao_escolar

USE gestao_escolar;

-- Passo 2: apagar as tabelas antigas (se existirem) para poder rodar o script varias vezes
-- A ordem é de trás para frente: primeiro as tabelas que têm FK
DROP TABLE IF EXISTS alunos_turmas;
DROP TABLE IF EXISTS turmas;
DROP TABLE IF EXISTS alunos;
DROP TABLE IF EXISTS instrutores;
DROP TABLE IF EXISTS cursos;
DROP TABLE IF EXISTS gestao;

-- =====================================================
-- Passo 3: tabelas que NAO dependem de nenhuma outra
-- =====================================================

-- Tabela gestao: controle administrativo e financeiro
CREATE TABLE gestao (
    id_gestao INT NOT NULL AUTO_INCREMENT,
    nome_responsavel VARCHAR(100)  NOT NULL,
    cpf_responsavel VARCHAR(15)   NOT NULL UNIQUE,
    valor_mensalidade DECIMAL(10,2) NOT NULL,
    matricula_aluno VARCHAR(1000) NOT NULL,  -- documentos entregues na secretaria
    PRIMARY KEY (id_gestao)
);

-- Tabela cursos: cursos de treinamento oferecidos pelo centro
-- Ajuste: no brModelo o status_cursos estava como TIME,
-- mas ele guarda texto (Ativo, Concluído...), então usei VARCHAR
CREATE TABLE cursos (
    id_cursos INT NOT NULL AUTO_INCREMENT,
    nome_curso VARCHAR(50)  NOT NULL,
    categoria_curso VARCHAR(30) NOT NULL,
    carga_horaria_curso INT NOT NULL,
    descricao_curso VARCHAR(500) NOT NULL,
    status_cursos VARCHAR(20)  NOT NULL,  -- Ativo, Em curso, Concluído, Cancelado
    PRIMARY KEY (id_cursos)
);

-- Tabela instrutores: instrutores, monitores e coordenadores do centro
CREATE TABLE instrutores (
    id_instrutores INT NOT NULL AUTO_INCREMENT,
    nome_instrutor VARCHAR(80) NOT NULL,
    cpf_instrutor VARCHAR(14) NOT NULL UNIQUE,
    telefone_instrutor VARCHAR(15) NOT NULL,
    cargo VARCHAR(30) NOT NULL,  -- Professor Titular, Monitor, Coordenador
    carga_horaria_instrutor INT NOT NULL,
    frequencia_trabalhados_por_semana VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_instrutores)
);

-- =====================================================
-- Passo 4: tabelas que dependem das anteriores (têm FK)
-- =====================================================

-- Tabela alunos
-- Relacionamento Administra (1:N): uma gestao administra vários alunos
CREATE TABLE alunos (
    id_aluno INT NOT NULL AUTO_INCREMENT,
    nome_aluno VARCHAR(100) NOT NULL,
    cpf_aluno VARCHAR(14) NOT NULL UNIQUE,
    email_aluno VARCHAR(100) NOT NULL UNIQUE,
    telefone_aluno VARCHAR(15) NOT NULL,
    idade_aluno INT NOT NULL CHECK (idade_aluno > 0),
    ano_escolar VARCHAR(20) NOT NULL,
    id_gestao INT NOT NULL,  -- FK que vem da tabela gestao
    PRIMARY KEY (id_aluno),
    FOREIGN KEY (id_gestao) REFERENCES gestao (id_gestao)
);

-- Tabela turmas
-- Relacionamento Possui (1:N): um curso possui várias turmas
-- Relacionamento Controla (1:N): um instrutor controla várias turmas
CREATE TABLE turmas (
    id_turma INT NOT NULL AUTO_INCREMENT,
    nome_turma VARCHAR(30) NOT NULL,
    turno VARCHAR(20) NOT NULL,
    sala VARCHAR(20) NOT NULL,
    horario_inicio_aula TIME NOT NULL,
    frequencia_por_semana VARCHAR(40) NOT NULL,
    quantidade_vagas INT NOT NULL CHECK (quantidade_vagas > 0),
    ano_conclusao INT NOT NULL,
    id_cursos INT NOT NULL,  -- FK que vem de cursos
    id_instrutores INT NOT NULL,  -- FK que vem de instrutores
    PRIMARY KEY (id_turma),
    FOREIGN KEY (id_cursos) REFERENCES cursos (id_cursos),
    FOREIGN KEY (id_instrutores) REFERENCES instrutores (id_instrutores)
);

-- =====================================================
-- Passo 5: tabela associativa do relacionamento N:N Participa
-- Um aluno pode estar em várias turmas e uma turma tem vários alunos
-- =====================================================
CREATE TABLE alunos_turmas (
    id_aluno INT NOT NULL,
    id_turma INT NOT NULL,
    data_inscricao DATE NOT NULL,
    PRIMARY KEY (id_aluno, id_turma),  -- chave primária composta
    FOREIGN KEY (id_aluno) REFERENCES alunos (id_aluno),
    FOREIGN KEY (id_turma) REFERENCES turmas (id_turma)
);

SHOW TABLES;