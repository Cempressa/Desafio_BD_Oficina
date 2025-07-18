-- queries.sql
USE `ordem_servico_db`;
-- 1. Recuperações simples com SELECT Statement
-- Pergunta: Quais são os nomes e telefones de todos os clientes cadastrados?
SELECT Nome,
    Telefone
FROM cliente;
-- Pergunta: Liste todas as equipes mecânicas e seus respectivos IDs.
SELECT idEquipe,
    NomeEquipe
FROM equipemecanica;
-- 2. Filtros com WHERE Statement
-- Pergunta: Quais veículos estão registrados para clientes Pessoa Jurídica (PJ)?
SELECT V.marca,
    V.modelo_ano,
    V.placa,
    C.Nome AS NomeCliente,
    C.Razao_Social_PJ
FROM veiculos V
    JOIN cliente C ON V.cliente_id = C.IdCliente
WHERE C.Tipo_Cliente = 'PJ';
-- Pergunta: Quais ordens de serviço estão atualmente em "Em Andamento" ou "Aguardando Aprovação"?
SELECT os_numero,
    data_os,
    status_os,
    defeito_reclamacao
FROM ordensservico
WHERE status_os IN ('Em Andamento', 'Aguardando Aprovação');
-- Pergunta: Quais peças têm menos de 50 unidades em estoque e seu preço de venda sugerido é superior a R$ 50,00?
SELECT nome,
    quantidade_estoque,
    preco_venda_sugerido
FROM pecas
WHERE quantidade_estoque < 50
    AND preco_venda_sugerido > 50.00;
-- 3. Crie expressões para gerar atributos derivados
-- Pergunta: Calcule o lucro potencial de cada peça em estoque, considerando a diferença entre o preço de venda sugerido e o preço de custo.
SELECT nome AS NomePeca,
    preco_custo,
    preco_venda_sugerido,
    (preco_venda_sugerido - preco_custo) AS LucroPotencialUnitario,
    (preco_venda_sugerido - preco_custo) * quantidade_estoque AS LucroPotencialTotalEstoque
FROM pecas;
-- Pergunta: Para cada ordem de serviço, mostre o número da OS, o valor da mão de obra, o valor das peças e o valor total (já calculado pela coluna gerada), e adicione uma coluna mostrando a margem de lucro sugerida sobre o valor total (ex: 15%).
SELECT os_numero,
    mao_de_obra,
    pecas,
    total AS ValorTotalOS,
    (total * 0.15) AS MargemLucroSugerida,
    (total * 1.15) AS ValorFinalComMargem
FROM ordensservico;
-- 4. Defina ordenações dos dados com ORDER BY
-- Pergunta: Liste todos os serviços em ordem decrescente de valor de mão de obra de referência.
SELECT descricao,
    valor_mao_de_obra_referencia
FROM servicos
ORDER BY valor_mao_de_obra_referencia DESC;
-- Pergunta: Mostre todos os veículos, ordenados primeiramente pela marca (A-Z) e depois pelo ano do modelo (do mais novo para o mais antigo).
SELECT marca,
    modelo_ano,
    placa
FROM veiculos
ORDER BY marca ASC,
    modelo_ano DESC;
-- 5. Condições de filtros aos grupos – HAVING Statement
-- Pergunta: Quais equipes mecânicas concluíram mais de 1 ordem de serviço e qual o total de OSs concluídas por elas?
SELECT EM.NomeEquipe,
    COUNT(OS.os_id) AS TotalOSConcluidas
FROM ordensservico OS
    JOIN equipemecanica EM ON OS.id_Equipe = EM.idEquipe
WHERE OS.status_os = 'Concluída'
GROUP BY EM.NomeEquipe
HAVING COUNT(OS.os_id) > 1;
-- Pergunta: Quais clientes têm mais de um veículo registrado?
SELECT C.Nome,
    COUNT(V.veiculo_id) AS TotalVeiculos
FROM cliente C
    JOIN veiculos V ON C.IdCliente = V.cliente_id
GROUP BY C.Nome
HAVING COUNT(V.veiculo_id) > 1;
-- 6. Crie junções entre tabelas para fornecer uma perspectiva mais complexa dos dados
-- Pergunta: Liste o nome do cliente, o modelo do veículo e o número da Ordem de Serviço para todas as ordens de serviço.
SELECT C.Nome AS NomeCliente,
    V.modelo_ano AS ModeloVeiculo,
    OS.os_numero AS NumeroOS,
    OS.status_os AS StatusOS
FROM cliente C
    JOIN veiculos V ON C.IdCliente = V.cliente_id
    JOIN ordensservico OS ON V.veiculo_id = OS.veiculo_id;
-- Pergunta: Quais peças foram utilizadas em ordens de serviço "Concluídas", qual o cliente e qual a equipe que executou o serviço?
SELECT P.nome AS NomePeca,
    IOP.quantidade AS QuantidadeUtilizada,
    OS.os_numero AS NumeroOS,
    C.Nome AS NomeCliente,
    EM.NomeEquipe AS EquipeResponsavel
FROM pecas P
    JOIN itensos_peca IOP ON P.id_peca = IOP.id_peca
    JOIN ordensservico OS ON IOP.id_os = OS.os_id
    JOIN veiculos V ON OS.veiculo_id = V.veiculo_id
    JOIN cliente C ON V.cliente_id = C.IdCliente
    JOIN equipemecanica EM ON OS.id_Equipe = EM.idEquipe
WHERE OS.status_os = 'Concluída';
-- Pergunta: Mostre o nome do mecânico, sua especialidade, a equipe a que pertence e todas as ordens de serviço (número e data) associadas à sua equipe.
SELECT M.Nome AS NomeMecanico,
    M.Especialidade,
    EM.NomeEquipe AS EquipeDoMecanico,
    OS.os_numero AS NumeroOS,
    OS.data_os AS DataOS,
    OS.status_os AS StatusOS
FROM mecanico M
    JOIN equipemecanica EM ON M.id_Equipe = EM.idEquipe
    LEFT JOIN ordensservico OS ON EM.idEquipe = OS.id_Equipe
ORDER BY M.Nome,
    OS.data_os;
-- Pergunta: Liste todos os serviços prestados em uma ordem de serviço específica (ex: 'OS2024003'), incluindo a descrição do serviço e o valor cobrado.
SELECT OS.os_numero,
    S.descricao AS DescricaoServico,
    ISS.valor_unitario_cobrado AS ValorCobrado,
    ISS.quantidade AS QuantidadeServico
FROM ordensservico OS
    JOIN itensos_servico ISS ON OS.os_id = ISS.id_os
    JOIN servicos S ON ISS.id_servico = S.id_servico
WHERE OS.os_numero = 'OS2024003';
-- Pergunta: Obtenha uma lista de todas as ordens de serviço, mostrando o cliente, o veículo, o mecânico responsável (se houver um mecânico principal na equipe) e o total da OS.
-- Nota: Como 'id_Equipe' é que está na OS, e não um mecânico direto, a junção será com a equipe. Para um mecânico específico, precisaríamos de uma FK direta na OS para 'mecanico'.
-- Para este exemplo, vamos trazer o nome de um mecânico da equipe, considerando o primeiro mecânico cadastrado para aquela equipe.
SELECT OS.os_numero,
    C.Nome AS NomeCliente,
    V.modelo_ano AS ModeloVeiculo,
    EM.NomeEquipe AS EquipeResponsavel,
    OS.total AS ValorTotalOS,
    M.Nome AS NomeMecanicoExemplo -- Exemplo: Primeiro mecânico da equipe
FROM ordensservico OS
    JOIN cliente C ON OS.veiculo_id IN (
        SELECT veiculo_id
        FROM veiculos
        WHERE cliente_id = C.IdCliente
    )
    JOIN veiculos V ON OS.veiculo_id = V.veiculo_id
    JOIN equipemecanica EM ON OS.id_Equipe = EM.idEquipe
    LEFT JOIN mecanico M ON EM.idEquipe = M.id_Equipe -- Junta com mecânico
GROUP BY OS.os_numero -- Agrupa para evitar duplicidade de mecânicos na mesma equipe
ORDER BY OS.os_numero;