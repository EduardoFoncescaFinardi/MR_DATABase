set SERVEROUTPUT on 
set verify off 

DROP TABLE NEGOCIOS;
DROP TABLE GARAGENS;
DROP TABLE AUTOMOVEIS;
DROP TABLE CONSUMIDORES;
DROP TABLE REVENDEDORAS;

---------------------------------------------------------------------------------------------

CREATE TABLE AUTOMOVEIS(
    codigo NUMBER(4) NOT NULL,
    fabricante VARCHAR2(20) NOT NULL,
    modelo VARCHAR2(10)  NOT NULL,
    ano NUMBER(4) NOT NULL,
    pais VARCHAR2(15),
    preco_tabela NUMBER(8,2) NOT NULL,
    CONSTRAINT AUTOMOVEIS_PK PRIMARY KEY (codigo)
);

CREATE TABLE REVENDEDORAS(
    cnpj VARCHAR2(16) NOT NULL,
    nome VARCHAR2(20) NOT NULL,
    proprietario VARCHAR2(20) NOT NULL,
    cidade VARCHAR(15) NOT NULL,
    estado CHAR(2) NOT NULL,
    CONSTRAINT REVENDEDORAS_PK PRIMARY KEY (cnpj)
);

CREATE TABLE CONSUMIDORES(
    id_con NUMBER(4) NOT NULL,
    nome VARCHAR2(20) NOT NULL,
    sobrenome VARCHAR2(15) NOT NULL,
    CONSTRAINT CONSUMIDORES_PK PRIMARY KEY (id_con)
);

CREATE TABLE GARAGENS(
    anoauto NUMBER(4) NOT NULL,
    quantidade NUMBER(4) NOT NULL,
    cnpjrevenda VARCHAR2(16) NOT NULL,
    codauto NUMBER(4) NOT NULL,
    CONSTRAINT GARAGENS_REVENDEDORAS_FK FOREIGN KEY (cnpjrevenda) REFERENCES REVENDEDORAS(cnpj),
    CONSTRAINT GARAGENS_AUTOMOVEIS_FK FOREIGN KEY (codauto) REFERENCES AUTOMOVEIS(codigo)
);

CREATE TABLE NEGOCIOS(
    anoauto NUMBER(4) NOT NULL,
    data DATE NOT NULL,
    preco NUMBER(8,2) NOT NULL,
    comprador NUMBER(4) NOT NULL,
    revenda VARCHAR2(16) NOT NULL,
    codauto NUMBER(4) NOT NULL,
    CONSTRAINT NEGOCIOS_CONSUMIDORES_FK FOREIGN KEY (comprador) REFERENCES CONSUMIDORES(id_con),
    CONSTRAINT NEGOCIOS_REVENDEDORAS_FK FOREIGN KEY (revenda) REFERENCES REVENDEDORAS(cnpj),
    CONSTRAINT NEGOCIOS_AUTOMOVEIS_FK FOREIGN KEY (codauto) REFERENCES AUTOMOVEIS(codigo)
);

---------------------------------------------------------------------------------------------

BEGIN
    INSERT INTO AUTOMOVEIS (codigo, fabricante, modelo, ano, pais, preco_tabela) VALUES (1001, 'Toyota', 'Corolla', 2020, 'Japão', 90000.00);
    INSERT INTO AUTOMOVEIS (codigo, fabricante, modelo, ano, pais, preco_tabela) VALUES (1002, 'Honda', 'Civic', 2019, 'Japão', 85000.00);
    INSERT INTO AUTOMOVEIS (codigo, fabricante, modelo, ano, pais, preco_tabela) VALUES (1003, 'Ford', 'Focus', 2018, 'EUA', 80000.00);
    INSERT INTO AUTOMOVEIS (codigo, fabricante, modelo, ano, pais, preco_tabela) VALUES (1004, 'Chevrolet', 'Cruze', 2021, 'EUA', 95000.00);
    INSERT INTO AUTOMOVEIS (codigo, fabricante, modelo, ano, pais, preco_tabela) VALUES (1005, 'Volkswagen', 'Golf', 2020, 'Alemanha', 92000.00);
    DBMS_OUTPUT.PUT_LINE('5 registros inseridos na tabela AUTOMOVEIS');
END;

BEGIN
    INSERT INTO REVENDEDORAS (cnpj, nome, proprietario, cidade, estado) VALUES ('12345678000101', 'Revenda A', 'João Silva', 'São Paulo', 'SP');
    INSERT INTO REVENDEDORAS (cnpj, nome, proprietario, cidade, estado) VALUES ('23456789000102', 'Revenda B', 'Maria Souza', 'Rio de Janeiro', 'RJ');
    INSERT INTO REVENDEDORAS (cnpj, nome, proprietario, cidade, estado) VALUES ('34567890000103', 'Revenda C', 'Carlos Pereira', 'Belo Horizonte', 'MG');
    INSERT INTO REVENDEDORAS (cnpj, nome, proprietario, cidade, estado) VALUES ('45678900000104', 'Revenda D', 'Ana Costa', 'Curitiba', 'PR');
    INSERT INTO REVENDEDORAS (cnpj, nome, proprietario, cidade, estado) VALUES ('56789000000105', 'Revenda E', 'Pedro Lima', 'Porto Alegre', 'RS');
    DBMS_OUTPUT.PUT_LINE('5 registros inseridos na tabela REVENDEDORAS');
END;

BEGIN
    INSERT INTO CONSUMIDORES (id_con, nome, sobrenome) VALUES (1, 'Lucas', 'Mendes');
    INSERT INTO CONSUMIDORES (id_con, nome, sobrenome) VALUES (2, 'Fernanda', 'Almeida');
    INSERT INTO CONSUMIDORES (id_con, nome, sobrenome) VALUES (3, 'Ricardo', 'Santos');
    INSERT INTO CONSUMIDORES (id_con, nome, sobrenome) VALUES (4, 'Juliana', 'Ferreira');
    INSERT INTO CONSUMIDORES (id_con, nome, sobrenome) VALUES (5, 'Marcos', 'Oliveira');
    DBMS_OUTPUT.PUT_LINE('5 registros inseridos na tabela CONSUMIDORES');
END;

BEGIN
    INSERT INTO GARAGENS (anoauto, quantidade, cnpjrevenda, codauto) VALUES (2020, 10, '12345678000101', 1001);
    INSERT INTO GARAGENS (anoauto, quantidade, cnpjrevenda, codauto) VALUES (2019, 8, '23456789000102', 1002);
    INSERT INTO GARAGENS (anoauto, quantidade, cnpjrevenda, codauto) VALUES (2018, 5, '34567890000103', 1003);
    INSERT INTO GARAGENS (anoauto, quantidade, cnpjrevenda, codauto) VALUES (2021, 12, '45678900000104', 1004);
    INSERT INTO GARAGENS (anoauto, quantidade, cnpjrevenda, codauto) VALUES (2020, 7, '56789000000105', 1005);
    DBMS_OUTPUT.PUT_LINE('5 registros inseridos na tabela GARAGENS');
END;

---------------------------------------------------------------------------------------------

