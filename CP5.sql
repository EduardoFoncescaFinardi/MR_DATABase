--------------------------------DROP-------------------------------

DROP TABLE T_AT_CLIENTE;
DROP TABLE T_AT_PACOTE;
DROP TABLE T_AT_HOSPEDAGEN;
DROP TABLE T_AT_RESERVA;

--------------------------------CREATE-------------------------------

CREATE TABLE T_AT_CLIENTE (
    id_cliente INT,
    nm_nome VARCHAR(100),
    vr_email VARCHAR(100),
    nr_telefone VARCHAR(15),
    CONSTRAINT T_AT_CLIENTE_PK PRIMARY KEY (id_cliente)
);

CREATE TABLE T_AT_PACOTE (
    id_pacote INT,
    ds_descricao VARCHAR(255),
    vl_preco DECIMAL(10, 2),
    qt_duracao_dias INT,
    CONSTRAINT T_AT_PACOTE_PK PRIMARY KEY (id_pacote)
);

CREATE TABLE T_AT_HOSPEDAGEN (
    id_hospedagem INT PRIMARY KEY,
    nm_hotel VARCHAR(100),
    nm_localizacao VARCHAR(100),
    vl_diaria DECIMAL(10, 2),
    CONSTRAINT T_AT_HOSPEDAGEM_PK PRIMARY KEY (id_hospedagem)
);

CREATE TABLE T_AT_RESERVA (
    id_reserva INT PRIMARY KEY,
    id_cliente INT,
    id_pacote INT,
    id_hospedagem INT,
    dt_reserva DATE,
    CONSTRAINT T_AT_RESERVA_PK PRIMARY KEY (id_reserva),
    CONSTRAINT T_AT_RESERVA_CLIENTE_FK FOREIGN KEY (id_cliente) REFERENCES T_AT_CLIENTE(id_cliente),
    CONSTRAINT T_AT_RESERVA_PACOTE_FK FOREIGN KEY (id_pacote) REFERENCES T_AT_CLIENTE(id_pacote),
    CONSTRAINT T_AT_RESERVA_HOSPEDAGEM_FK FOREIGN KEY (id_hospedagem) REFERENCES T_AT_CLIENTE(id_hospedagem)
);

--------------------------------INSERT-------------------------------

INSERT INTO T_AT_CLIENTE (id_cliente, nm_nome, vr_email, nr_telefone) VALUES
(1, 'Lucca', 'lc@gmail.com', '1111'),
(2, 'Eduardo', 'ed@egmail.com', '2222'),
(3, 'João', 'jo@gmail.com', '3333'),
(4, 'Felipe', 'Fe@gmail.com', '4444'),
(5, 'Fulano', 'Fu@gmail.com', '5555');

INSERT INTO T_AT_PACOTE (id_pacote, ds_descricao, vl_preco, qt_duracao_dias) VALUES
(1, 'Pacote 1', 5200, 7),
(2, 'Pacote 2', 2000, 2),
(3, 'Pacote 3', 8900, 12),
(4, 'Pacote 4', 4000, 6),
(5, 'Pacote 5', 6300, 8);

INSERT INTO T_AT_HOSPEDAGEN (id_hospedagem, nm_hotel, nm_localizacao, vl_diaria) VALUES
(1, 'Hotel Paris', 'Paris', 200.00),
(2, 'Hotel NY', 'Nova York', 300.00),
(3, 'Hotel Tokyo', 'Tóquio', 250.00),
(4, 'Hotel Roma', 'Roma', 180.00),
(5, 'Hotel London', 'Londres', 220.00);

INSERT INTO T_AT_RESERVA (id_reserva, id_cliente, id_pacote, id_hospedagem, dt_reserva) VALUES
(1, 1, 1, 1, '2023-01-15'),
(2, 2, 2, 2, '2023-02-20'),
(3, 3, 3, 3, '2023-03-25'),
(4, 4, 4, 4, '2023-04-30'),
(5, 5, 5, 5, '2023-05-05');