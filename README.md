# Desafio de Projeto: Banco de Dados para Oficina Mecânica

Este repositório contém o projeto de banco de dados desenvolvido como parte do desafio de modelagem e implementação de Banco de Dados. O objetivo é criar um esquema lógico para o contexto de uma oficina mecânica, incluindo a criação do script SQL, persistência de dados e elaboração de queries complexas.

## Esquema Lógico do Banco de Dados

O esquema conceitual original foi transformado em um modelo relacional, focado em representar as principais entidades e seus relacionamentos dentro de uma oficina:

* **`cliente`**: Armazena informações de clientes (Pessoa Física e Jurídica).
    * `IdCliente` (PK)
    * `Tipo_Cliente` (ENUM 'PF', 'PJ')
    * `CPF`, `RG`, `CNPJ`, `Razao_Social_PJ` (condicionais ao tipo de cliente)
    * `Email`, `Telefone`, Endereço, `Data_Cadastro`
* **`equipemecanica`**: Contém as diferentes equipes de trabalho da oficina.
    * `idEquipe` (PK)
    * `NomeEquipe`
* **`mecanico`**: Detalhes dos mecânicos e suas especialidades, associados a uma equipe.
    * `idMecanico` (PK)
    * `Codigo`, `Nome`, `Endereco`, `Especialidade`, `Telefone`
    * `id_Equipe` (FK para `equipemecanica`)
* **`veiculos`**: Informações dos veículos dos clientes.
    * `veiculo_id` (PK)
    * `cliente_id` (FK para `cliente`)
    * `marca`, `modelo_ano`, `placa`, `numero_chassis`, `numero_patrimonio`
* **`ordensservico`**: Principal tabela que registra as ordens de serviço.
    * `os_id` (PK), `os_numero`
    * `data_os`, `veiculo_id` (FK para `veiculos`)
    * `defeito_reclamacao`, `servicos_executados_local`, `garantia`, `proxima_revisao`
    * `mao_de_obra`, `pecas`, `total` (coluna gerada: `mao_de_obra + pecas`)
    * `id_Equipe` (FK para `equipemecanica`)
    * `status_os` (ENUM: 'Aberta', 'Em Andamento', 'Aguardando Aprovação', 'Aguardando Peças', 'Concluída', 'Cancelada')
    * `data_prev_conclusao`, `data_autorizacao_cliente`
* **`pecas`**: Catálogo de peças disponíveis na oficina.
    * `id_peca` (PK)
    * `nome`, `descricao`, `preco_custo`, `preco_venda_sugerido`, `quantidade_estoque`
* **`servicos`**: Catálogo de serviços oferecidos pela oficina.
    * `id_servico` (PK)
    * `descricao`, `valor_mao_de_obra_referencia`, `especialidade_requerida`
* **`itensos_peca`**: Itens de peças utilizadas em cada ordem de serviço.
    * `id_item_os_peca` (PK)
    * `id_os` (FK para `ordensservico`), `id_peca` (FK para `pecas`)
    * `quantidade`, `valor_unitario_cobrado`
* **`itensos_servico`**: Itens de serviços realizados em cada ordem de serviço.
    * `id_item_os_servico` (PK)
    * `id_os` (FK para `ordensservico`), `id_servico` (FK para `servicos`)
    * `quantidade`, `valor_unitario_cobrado`, `descricao_adicional`

## Estrutura do Repositório

* `schema.sql`: Contém o script DDL para a criação do banco de dados `ordem_servico_db` e todas as suas tabelas com suas respectivas chaves e restrições.
* `data.sql`: Contém os comandos DML (`INSERT INTO`) para popular as tabelas com dados de teste.
* `queries.sql`: Contém diversas queries SQL complexas, demonstrando o uso de:
    * `SELECT` Statement
    * `WHERE` Statement
    * Expressões para atributos derivados
    * `ORDER BY`
    * `HAVING` Statement
    * `JOIN`s entre tabelas

## Como Executar os Scripts

Para replicar o banco de dados e executar as consultas:

1.  Certifique-se de ter o MySQL Server e um cliente (como MySQL Workbench) instalados.
2.  Abra o `schema.sql` no seu cliente MySQL e execute-o para criar o banco de dados e as tabelas.
3.  Abra o `data.sql` no seu cliente MySQL (certifique-se de que o banco `ordem_servico_db` esteja selecionado/ativo) e execute-o para inserir os dados de teste.
4.  Abra o `queries.sql` e execute as consultas que desejar. **Nota:** Para a última query (`Obtenha uma lista de todas as ordens de serviço...`), pode ser necessário desabilitar temporariamente o `ONLY_FULL_GROUP_BY` na sua sessão (`SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));`) ou usar funções de agregação como `MIN()` ou `MAX()` para as colunas não agregadas no `SELECT` quando usando `GROUP BY`.
