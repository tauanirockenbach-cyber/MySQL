USE cinema;

-- 1. Inserir Categorias
INSERT INTO categoria (descricao_cat) VALUES ('Ação'), ('Comédia'), ('Terror'), ('Infantil');

-- 2. Inserir Filmes
INSERT INTO filme (nome_filme, faixa_etaria, duracao_filme, status_filme, id_cat) VALUES 
('Vingadores: O Retorno', 12, 150, 'EM CARTAZ', 1),
('Riso Solto', 10, 90, 'EM CARTAZ', 2),
('A Bruxa da Meia-Noite', 16, 110, 'FORA CARTAZ', 3);

-- 3. Inserir Salas
INSERT INTO sala (descricao_sala, tipo_sala, capacidade_sala, vip_sala) VALUES 
('Sala 1 - Principal', '3D', 100, FALSE),
('Sala 2 - IMAX', 'IMAX', 50, TRUE),
('Sala 3 - Padrão', '2D', 150, FALSE);

-- 4. Inserir Sessões
INSERT INTO sessao (data_hora, status_sessao, id_sala, id_filme) VALUES 
('2026-05-01 18:00:00', 'ABERTA', 1, 1),
('2026-05-01 20:00:00', 'ABERTA', 2, 2),
('2026-05-02 15:00:00', 'ENCERRADA', 3, 3);

-- 5. Inserir Tipos de Ingresso
INSERT INTO tipo_ingresso (descricao_ingresso, valor_ingresso) VALUES 
('Inteira', 30.00),
('Meia-Entrada', 15.00),
('VIP', 50.00);

-- 6. Inserir Clientes
INSERT INTO cliente (nome_cliente, cpf_cliente, email_cliente, status_cliente) VALUES 
('João Silva', '12345678901', 'joao@email.com', 'ATIVO'),
('Maria Souza', '98765432100', 'maria@email.com', 'ATIVO'),
('Carlos Pereira', '55566677788', 'carlos@email.com', 'INATIVO');

-- 7. Inserir Pedidos
INSERT INTO pedido (data_hora, id_cliente, status_pedido) VALUES 
(NOW(), 1, 'PAGO'),
(NOW(), 2, 'ABERTO');

-- 8. Inserir Ingressos
INSERT INTO ingresso (id_pedido, id_sessao, id_tipo_ingresso, valor_pago, status_ingresso) VALUES 
(1, 1, 1, 30.00, 'PAGO'), -- João comprou inteira pro Vingadores
(1, 1, 2, 15.00, 'PAGO'), -- João comprou meia pro Vingadores
(2, 2, 3, 50.00, 'RESERVADO'); -- Maria reservou VIP pro Riso Solto
