# ProjetoTreinamento – Banco de Dados de um Centro de Treinamento

Projeto acadêmico de banco de dados relacional em **MySQL** para gerenciar um **Centro de Treinamento** (cursos, turmas, instrutores, alunos e mensalidades), feito a partir do modelo conceitual criado no brModelo.

## Como executar no VS Code

1. Instale o MySQL (8.0.16 ou mais novo, por causa dos `CHECK`) e a extensão **MySQL** (ou *SQLTools* + driver MySQL) no VS Code.
2. Conecte no seu servidor MySQL pela extensão.
3. Abra e execute os arquivos **nesta ordem**:

| Ordem | Arquivo | O que faz |
|---|---|---|
| 1 | `sql/01_ddl_estrutura.sql` | Cria o banco `gestao_escolar` e as tabelas |
| 2 | `sql/02_dml_dados.sql` | Insere dados de exemplo, UPDATE e DELETE |
| 3 | `sql/03_dql_consultas.sql` | Consultas SELECT (JOIN, GROUP BY, HAVING...) |
| 4 | `sql/04_tcl_transacao.sql` | Transações (COMMIT, ROLLBACK, SAVEPOINT) |

Pelo terminal também funciona:

```bash
mysql -u root -p < sql/01_ddl_estrutura.sql
mysql -u root -p < sql/02_dml_dados.sql
mysql -u root -p < sql/03_dql_consultas.sql
mysql -u root -p < sql/04_tcl_transacao.sql
```

## Tabelas

- `gestao` – responsáveis financeiros, mensalidades e documentos entregues na secretaria do centro
- `alunos` – dados dos alunos (FK `id_gestao`)
- `cursos` – cursos oferecidos
- `instrutores` – instrutores, monitores e coordenadores do centro
- `turmas` – turmas abertas (FKs `id_cursos` e `id_instrutores`)
- `alunos_turmas` – tabela associativa do N:N entre alunos e turmas (PK composta)

## Relacionamentos

| Relacionamento | Tipo | Como ficou no banco |
|---|---|---|
| Administra | 1:N (gestao → alunos) | FK `id_gestao` em `alunos` |
| Possui | 1:N (cursos → turmas) | FK `id_cursos` em `turmas` |
| Controla | 1:N (instrutores → turmas) | FK `id_instrutores` em `turmas` |
| Participa | N:N (alunos ↔ turmas) | tabela `alunos_turmas` |

## Ajuste em relação ao brModelo

O atributo `status_cursos` estava como `TIME` no modelo, mas ele guarda textos como "Ativo" ou "Concluído". No SQL usei `VARCHAR(20)`.
