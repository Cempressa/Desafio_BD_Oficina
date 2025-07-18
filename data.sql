-- data.sql
USE `ordem_servico_db`;
-- Inserindo dados na tabela equipemecanica
INSERT INTO equipemecanica (NomeEquipe)
VALUES ('Equipe Alpha'),
    ('Equipe Beta'),
    ('Equipe Gamma');
-- Inserindo dados na tabela mecanico
INSERT INTO mecanico (
        Codigo,
        Nome,
        Endereco,
        Especialidade,
        Telefone,
        id_Equipe
    )
VALUES (
        'MEC001',
        'João Silva',
        'Rua das Flores, 100, Centro, SP',
        'Motor',
        '11987654321',
        1
    ),
    (
        'MEC002',
        'Maria Santos',
        'Av. Principal, 50, Bairro Novo, SP',
        'Freios',
        '11987654322',
        1
    ),
    (
        'MEC003',
        'Carlos Souza',
        'Rua da Paz, 20, Vila Antiga, SP',
        'Suspensão',
        '11987654323',
        2
    ),
    (
        'MEC004',
        'Ana Pereira',
        'Travessa Sete, 15, Cidade Industrial, SP',
        'Elétrica',
        '11987654324',
        2
    ),
    (
        'MEC005',
        'Pedro Costa',
        'Rua do Sol, 300, Praia, SP',
        'Pintura',
        '11987654325',
        3
    );
-- Inserindo dados na tabela cliente
INSERT INTO cliente (
        Nome,
        Tipo_Cliente,
        CPF,
        RG,
        CNPJ,
        Razao_Social_PJ,
        Email,
        Telefone,
        Logradouro,
        Numero,
        Complemento,
        Bairro,
        Cidade,
        Estado,
        CEP
    )
VALUES (
        'Alice Souza',
        'PF',
        '111.222.333-44',
        '12.345.678-9',
        NULL,
        NULL,
        'alice@email.com',
        '11999999999',
        'Rua A',
        '123',
        NULL,
        'Centro',
        'São Paulo',
        'SP',
        '01000-000'
    ),
    (
        'Bruno Lima',
        'PF',
        '555.666.777-88',
        '98.765.432-1',
        NULL,
        NULL,
        'bruno@email.com',
        '11988888888',
        'Av. Brasil',
        '45',
        'Apto 10',
        'Jardins',
        'São Paulo',
        'SP',
        '02000-000'
    ),
    (
        'Conserto Já LTDA',
        'PJ',
        NULL,
        NULL,
        '12.345.678/0001-90',
        'Conserto Já Reparos Automotivos LTDA',
        'contato@consertoj.com',
        '1133334444',
        'Rua B',
        '10',
        'Sala 2',
        'Industrial',
        'Campinas',
        'SP',
        '13000-000'
    ),
    (
        'Daniel Costa',
        'PF',
        '999.888.777-66',
        '11.222.333-4',
        NULL,
        NULL,
        'daniel@email.com',
        '11977777777',
        'Av. Paulista',
        '500',
        NULL,
        'Bela Vista',
        'São Paulo',
        'SP',
        '03000-000'
    ),
    (
        'Eletro Car S.A.',
        'PJ',
        NULL,
        NULL,
        '98.765.432/0001-10',
        'Eletro Car Serviços Elétricos Automotivos S.A.',
        'vendas@eletrocar.com',
        '1955556666',
        'Rua C',
        '200',
        NULL,
        'Comercial',
        'Campinas',
        'SP',
        '13100-000'
    );
-- Inserindo dados na tabela veiculos
INSERT INTO veiculos (
        cliente_id,
        marca,
        modelo_ano,
        placa,
        numero_chassis,
        numero_patrimonio
    )
VALUES (
        1,
        'Fiat',
        'Palio 2015',
        'ABC1D23',
        'CHAS001ABC123',
        NULL
    ),
    (
        1,
        'Ford',
        'Ka 2018',
        'DEF4G56',
        'CHAS002DEF456',
        NULL
    ),
    (
        2,
        'Chevrolet',
        'Onix 2020',
        'GHI7J89',
        'CHAS003GHI789',
        NULL
    ),
    (
        3,
        'Volkswagen',
        'Amarok 2022',
        'KLM0N12',
        'CHAS004KLM012',
        'PATR1001'
    ),
    (
        4,
        'Renault',
        'Kwid 2019',
        'OPQ3R45',
        'CHAS005OPQ345',
        NULL
    ),
    (
        5,
        'Mercedes-Benz',
        'Sprinter 2023',
        'RST6U78',
        'CHAS006RST678',
        'PATR1002'
    );
-- Inserindo dados na tabela servicos
INSERT INTO servicos (
        descricao,
        valor_mao_de_obra_referencia,
        especialidade_requerida
    )
VALUES ('Troca de Óleo', 80.00, 'Motor'),
    (
        'Alinhamento e Balanceamento',
        120.00,
        'Suspensão'
    ),
    ('Revisão Completa (10.000km)', 350.00, 'Geral'),
    ('Reparo Freio Dianteiro', 150.00, 'Freios'),
    ('Diagnóstico Elétrico', 100.00, 'Elétrica'),
    ('Pintura Parachoque', 400.00, 'Pintura');
-- Inserindo dados na tabela pecas
INSERT INTO pecas (
        nome,
        descricao,
        preco_custo,
        preco_venda_sugerido,
        quantidade_estoque
    )
VALUES (
        'Filtro de Óleo',
        'Filtro para motor',
        15.00,
        25.00,
        100
    ),
    (
        'Pastilha de Freio',
        'Pastilha de freio dianteira',
        50.00,
        85.00,
        50
    ),
    (
        'Vela de Ignição',
        'Vela de ignição para motor a gasolina',
        10.00,
        18.00,
        200
    ),
    (
        'Amortecedor Dianteiro',
        'Amortecedor para suspensão',
        120.00,
        200.00,
        30
    ),
    (
        'Lâmpada Farol',
        'Lâmpada halógena H4',
        8.00,
        15.00,
        150
    );
-- Inserindo dados na tabela ordensservico
INSERT INTO ordensservico (
        os_numero,
        data_os,
        veiculo_id,
        defeito_reclamacao,
        servicos_executados_local,
        garantia,
        proxima_revisao,
        mao_de_obra,
        pecas,
        id_Equipe,
        status_os,
        data_prev_conclusao,
        data_autorizacao_cliente
    )
VALUES (
        'OS2024001',
        '2024-06-10',
        1,
        'Troca de óleo e filtro',
        'Serviço de troca de óleo e filtro realizado.',
        '3 meses',
        '2024-12-10',
        80.00,
        25.00,
        1,
        'Concluída',
        '2024-06-10',
        '2024-06-09 10:00:00'
    ),
    (
        'OS2024002',
        '2024-06-12',
        2,
        'Barulho na suspensão dianteira',
        'Substituição de batentes e coxins da suspensão.',
        '6 meses',
        '2025-06-12',
        150.00,
        0.00,
        2,
        'Em Andamento',
        '2024-06-15',
        '2024-06-11 14:30:00'
    ),
    (
        'OS2024003',
        '2024-06-15',
        3,
        'Revisão geral',
        'Revisão de 10.000km realizada. Verificação de fluídos, freios, suspensão.',
        '1 ano',
        '2025-06-15',
        350.00,
        50.00,
        1,
        'Concluída',
        '2024-06-15',
        '2024-06-14 09:00:00'
    ),
    (
        'OS2024004',
        '2024-06-18',
        4,
        'Problema no sistema elétrico',
        'Diagnóstico inicial. Aguardando aprovação do orçamento para reparo.',
        NULL,
        NULL,
        100.00,
        0.00,
        2,
        'Aguardando Aprovação',
        '2024-06-20',
        NULL
    ),
    (
        'OS2024005',
        '2024-06-20',
        5,
        'Pastilhas de freio gastas',
        'Troca de pastilhas de freio dianteiras.',
        '6 meses',
        '2024-12-20',
        100.00,
        85.00,
        1,
        'Concluída',
        '2024-06-20',
        '2024-06-19 11:00:00'
    ),
    (
        'OS2024006',
        '2024-06-22',
        1,
        'Pintura parachoque traseiro',
        'Remoção de amassado e repintura do parachoque.',
        '1 ano',
        NULL,
        400.00,
        0.00,
        3,
        'Em Andamento',
        '2024-06-25',
        '2024-06-21 16:00:00'
    ),
    (
        'OS2024007',
        '2024-07-01',
        6,
        'Revisão preventiva',
        NULL,
        NULL,
        '2025-07-01',
        200.00,
        0.00,
        3,
        'Aberta',
        '2024-07-05',
        NULL
    );
-- Inserindo dados na tabela itensos_peca
INSERT INTO itensos_peca (
        id_os,
        id_peca,
        quantidade,
        valor_unitario_cobrado
    )
VALUES (1, 1, 1, 25.00),
    -- OS2024001: Filtro de Óleo
    (3, 1, 1, 25.00),
    -- OS2024003: Filtro de Óleo
    (5, 2, 2, 85.00);
-- OS2024005: Pastilha de Freio
-- Inserindo dados na tabela itensos_servico
INSERT INTO itensos_servico (
        id_os,
        id_servico,
        quantidade,
        valor_unitario_cobrado,
        descricao_adicional
    )
VALUES (1, 1, 1, 80.00, 'Troca de óleo 5W30'),
    -- OS2024001: Troca de Óleo
    (
        2,
        2,
        1,
        120.00,
        'Alinhamento 3D e Balanceamento'
    ),
    -- OS2024002: Alinhamento e Balanceamento
    (3, 3, 1, 350.00, 'Revisão padrão de 10.000km'),
    -- OS2024003: Revisão Completa
    (
        4,
        5,
        1,
        100.00,
        'Diagnóstico de anomalia no sistema elétrico'
    ),
    -- OS2024004: Diagnóstico Elétrico
    (
        5,
        4,
        1,
        150.00,
        'Reparo e substituição de pastilhas'
    ),
    -- OS2024005: Reparo Freio Dianteiro
    (
        6,
        6,
        1,
        400.00,
        'Pintura e funilaria do parachoque'
    );
-- OS2024006: Pintura Parachoque