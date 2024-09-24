--INTEGRANTES--
-- Eduardo Foncesca Finardi | RM:98624
-- Lucca Rinaldi | RM: 98207
-- João Gabriel Cardoso | RM: 552078
-- Felipe Morais | RM:551463
---------------

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

CREATE TABLE T_AT_HOSPEDAGEM (
    id_hospedagem INT,
    nm_hotel VARCHAR(100),
    nm_localizacao VARCHAR(100),
    vl_diaria DECIMAL(10, 2),
    CONSTRAINT T_AT_HOSPEDAGEM_PK PRIMARY KEY (id_hospedagem)
);

CREATE TABLE T_AT_RESERVA (
    id_reserva INT,
    id_cliente INT,
    id_pacote INT,
    id_hospedagem INT,
    dt_reserva DATE,
    CONSTRAINT T_AT_RESERVA_PK PRIMARY KEY (id_reserva),
    CONSTRAINT T_AT_RESERVA_CLIENTE_FK FOREIGN KEY (id_cliente) REFERENCES T_AT_CLIENTE(id_cliente),
    CONSTRAINT T_AT_RESERVA_PACOTE_FK FOREIGN KEY (id_pacote) REFERENCES T_AT_PACOTE(id_pacote),
    CONSTRAINT T_AT_RESERVA_HOSPEDAGEM_FK FOREIGN KEY (id_hospedagem) REFERENCES T_AT_HOSPEDAGEM(id_hospedagem)
);

--------------------------------INSERT-------------------------------

INSERT INTO T_AT_CLIENTE (id_cliente, nm_nome, vr_email, nr_telefone) VALUES (1, 'Lucca', 'lc@gmail.com', '1111');
INSERT INTO T_AT_CLIENTE (id_cliente, nm_nome, vr_email, nr_telefone) VALUES (2, 'Eduardo', 'ed@egmail.com', '2222');
INSERT INTO T_AT_CLIENTE (id_cliente, nm_nome, vr_email, nr_telefone) VALUES (3, 'João', 'jo@gmail.com', '3333');
INSERT INTO T_AT_CLIENTE (id_cliente, nm_nome, vr_email, nr_telefone) VALUES (4, 'Felipe', 'Fe@gmail.com', '4444');
INSERT INTO T_AT_CLIENTE (id_cliente, nm_nome, vr_email, nr_telefone) VALUES (5, 'Fulano', 'Fu@gmail.com', '5555');

------------------------------------------------------------------------

INSERT INTO T_AT_PACOTE (id_pacote, ds_descricao, vl_preco, qt_duracao_dias) VALUES (1, 'Pacote 1', 5200, 7);
INSERT INTO T_AT_PACOTE (id_pacote, ds_descricao, vl_preco, qt_duracao_dias) VALUES (2, 'Pacote 2', 2000, 2);
INSERT INTO T_AT_PACOTE (id_pacote, ds_descricao, vl_preco, qt_duracao_dias) VALUES (3, 'Pacote 3', 8900, 12);
INSERT INTO T_AT_PACOTE (id_pacote, ds_descricao, vl_preco, qt_duracao_dias) VALUES (4, 'Pacote 4', 4000, 6);
INSERT INTO T_AT_PACOTE (id_pacote, ds_descricao, vl_preco, qt_duracao_dias) VALUES (5, 'Pacote 5', 6300, 8);

------------------------------------------------------------------------

INSERT INTO T_AT_HOSPEDAGEM (id_hospedagem, nm_hotel, nm_localizacao, vl_diaria) VALUES (1, 'Hotel 1', 'SP, São Paulo', 320);
INSERT INTO T_AT_HOSPEDAGEM (id_hospedagem, nm_hotel, nm_localizacao, vl_diaria) VALUES (2, 'Hotel 2', 'RJ, Rio de Janeiro', 300);
INSERT INTO T_AT_HOSPEDAGEM (id_hospedagem, nm_hotel, nm_localizacao, vl_diaria) VALUES (3, 'Hotel 3', 'ES, Vitória', 150);
INSERT INTO T_AT_HOSPEDAGEM (id_hospedagem, nm_hotel, nm_localizacao, vl_diaria) VALUES (4, 'Hotel 4', 'MG, Belo Horizonte', 180);
INSERT INTO T_AT_HOSPEDAGEM (id_hospedagem, nm_hotel, nm_localizacao, vl_diaria) VALUES (5, 'Hotel 5', 'PR, Curitiba', 220);

------------------------------------------------------------------------

INSERT INTO T_AT_RESERVA (id_reserva, id_cliente, id_pacote, id_hospedagem, dt_reserva) VALUES (1, 1, 1, 1, '19/08/2004');
INSERT INTO T_AT_RESERVA (id_reserva, id_cliente, id_pacote, id_hospedagem, dt_reserva) VALUES (2, 2, 2, 2, '29/10/2002');
INSERT INTO T_AT_RESERVA (id_reserva, id_cliente, id_pacote, id_hospedagem, dt_reserva) VALUES (3, 3, 3, 3, '12/03/2005');
INSERT INTO T_AT_RESERVA (id_reserva, id_cliente, id_pacote, id_hospedagem, dt_reserva) VALUES (4, 4, 4, 4, '13/03/2004');
INSERT INTO T_AT_RESERVA (id_reserva, id_cliente, id_pacote, id_hospedagem, dt_reserva) VALUES (5, 5, 5, 5, '10/10/2000');

--------------------------------SELECT-------------------------------

SELECT * FROM T_AT_CLIENTE;
SELECT * FROM T_AT_PACOTE;
SELECT * FROM T_AT_HOSPEDAGEM;
SELECT * FROM T_AT_RESERVA;

--------------------------------FUNÇÃO-------------------------------
SET SERVEROUTPUT ON
SET VERIFY OFF
