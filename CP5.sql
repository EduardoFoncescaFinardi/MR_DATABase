--INTEGRANTES--
-- Eduardo Foncesca Finardi | RM:98624
-- Lucca Rinaldi | RM: 98207
-- João Gabriel Cardoso | RM: 552078
-- Felipe Morais | RM:551463
---------------

--------------------------------DROP--------------------------------

DROP TABLE T_AT_RESERVA;
DROP TABLE T_AT_PACOTE;
DROP TABLE T_AT_HOSPEDAGEM;
DROP TABLE T_AT_CLIENTE;
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

----------------------CRIAÇÃO DO PACOTE------------------------------

SET SERVEROUTPUT ON
SET VERIFY OFF

CREATE OR REPLACE PACKAGE PKG_GERENCIAMENTO_VIAGENS AS
    PROCEDURE PRC_LISTAR_RESERVAS_POR_CLIENTE(p_id_cliente IN INT);

    FUNCTION FUNC_CALCULAR_CUSTO_TOTAL_RESERVA(p_id_reserva IN INT) RETURN DECIMAL;
END PKG_GERENCIAMENTO_VIAGENS;

-----------------IMPLEMENTAÇÃO DO PACOTE-----------------------------

CREATE OR REPLACE PACKAGE BODY PKG_GERENCIAMENTO_VIAGENS AS

    PROCEDURE PRC_LISTAR_RESERVAS_POR_CLIENTE(p_id_cliente IN INT) IS
    BEGIN
        FOR r IN (SELECT r.id_reserva, r.dt_reserva, p.ds_descricao, h.nm_hotel FROM T_AT_RESERVA r
                  JOIN T_AT_PACOTE p ON r.id_pacote = p.id_pacote JOIN T_AT_HOSPEDAGEM h ON r.id_hospedagem = h.id_hospedagem
                  WHERE r.id_cliente = p_id_cliente) LOOP
            DBMS_OUTPUT.PUT_LINE('Reserva ID: ' || r.id_reserva || ', Data: ' || r.dt_reserva || ', Pacote: ' || r.ds_descricao || ', Hotel: ' || r.nm_hotel);
        END LOOP;
    END PRC_LISTAR_RESERVAS_POR_CLIENTE;

    FUNCTION FUNC_CALCULAR_CUSTO_TOTAL_RESERVA(p_id_reserva IN INT) RETURN DECIMAL IS
        v_preco_pacote DECIMAL(10, 2);
        v_diaria_hospedagem DECIMAL(10, 2);
        v_duracao_dias INT;
        v_custo_total DECIMAL(10, 2);
    BEGIN
        SELECT p.vl_preco, h.vl_diaria, p.qt_duracao_dias INTO v_preco_pacote, v_diaria_hospedagem, v_duracao_dias FROM T_AT_RESERVA r
        JOIN T_AT_PACOTE p ON r.id_pacote = p.id_pacote JOIN T_AT_HOSPEDAGEM h ON r.id_hospedagem = h.id_hospedagem
        WHERE r.id_reserva = p_id_reserva;

        v_custo_total := v_preco_pacote + (v_diaria_hospedagem * v_duracao_dias);
        RETURN v_custo_total;
    END FUNC_CALCULAR_CUSTO_TOTAL_RESERVA;

END PKG_GERENCIAMENTO_VIAGENS;

--------------------------------TESTE--------------------------------------

-- TESTE 1 PRC
BEGIN
    PKG_GERENCIAMENTO_VIAGENS.PRC_LISTAR_RESERVAS_POR_CLIENTE(2);
END;

-- TESTE 2 PRC
BEGIN
    PKG_GERENCIAMENTO_VIAGENS.PRC_LISTAR_RESERVAS_POR_CLIENTE(3);
END;

-- TESTE 1 FUNC 
DECLARE
    v_custo_total DECIMAL(10, 2);
BEGIN
    v_custo_total := PKG_GERENCIAMENTO_VIAGENS.FUNC_CALCULAR_CUSTO_TOTAL_RESERVA(1);
    DBMS_OUTPUT.PUT_LINE('Custo total da reserva: ' || v_custo_total);
END;

-- TESTE 2 FUNC
DECLARE
    v_custo_total DECIMAL(10, 2);
BEGIN
    v_custo_total := PKG_GERENCIAMENTO_VIAGENS.FUNC_CALCULAR_CUSTO_TOTAL_RESERVA(4);
    DBMS_OUTPUT.PUT_LINE('Custo total da reserva: ' || v_custo_total);
END;
