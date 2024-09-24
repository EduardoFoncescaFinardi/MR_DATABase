DROP TABLE T_AT_CLIENTE;
DROP TABLE T_AT_PACOTE;
DROP TABLE T_AT_HOSPEDAGEN;
DROP TABLE T_AT_RESERVA;

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
    qt_duracao INT,
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
