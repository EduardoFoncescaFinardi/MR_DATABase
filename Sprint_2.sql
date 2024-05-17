--------------------------------------------------------------------
------------------------------SPRINT 1------------------------------
--------------------------------------------------------------------
DROP SEQUENCE SEQ_ANALISE_DA_CONSULTA;
DROP SEQUENCE SEQ_REPRESENTANTE;
DROP SEQUENCE SEQ_CONSULTA;
DROP SEQUENCE SEQ_TELEFONE_EMPRESA;
DROP SEQUENCE SEQ_ENDERECO_EMPRESA;
DROP SEQUENCE SEQ_LOGIN;
DROP SEQUENCE SEQ_EMAIL_CONTATO;
DROP SEQUENCE SEQ_CADASTRO;
--------------------------------------------------------------------
DROP TABLE T_TC_ANALISE_DA_CONSULTA;
DROP TABLE T_TC_REPRESENTANTE;
DROP TABLE T_TC_CONSULTA;
DROP TABLE T_TC_TELEFONE_EMPRESA;
DROP TABLE T_TC_ENDERECO_EMPRESA;
DROP TABLE T_TC_LOGIN;
DROP TABLE T_TC_EMAIL_CONTATO;
DROP TABLE T_TC_CADASTRO;
--------------------------------------------------------------------
CREATE TABLE T_TC_CADASTRO(
  id_cadastro NUMERIC NOT NULL,
  nr_cnpj NUMERIC(14) NOT NULL,
  varchar_senha VARCHAR(60) NOT NULL,
  nm_razaosocial VARCHAR(80) NOT NULL,
  CONSTRAINT T_TC_CADASTRO_PK PRIMARY KEY (id_cadastro)
);

CREATE SEQUENCE SEQ_CADASTRO
  START WITH 1
  INCREMENT BY 1
  MINVALUE 0
  MAXVALUE 1000
  NOCYCLE;
--------------------------------------------------------------------
CREATE TABLE T_TC_EMAIL_CONTATO(
  id_email_contato NUMERIC NOT NULL,
  varchar_email VARCHAR(80),
  id_cadastro NUMERIC NOT NULL,
  CONSTRAINT T_TC_EMAIL_CONTATO_PK PRIMARY KEY (id_email_contato),
  CONSTRAINT T_TC_CADASTRO_EMAIL_CONTATO_FK FOREIGN KEY (id_cadastro) REFERENCES T_TC_CADASTRO(id_cadastro)
);

CREATE SEQUENCE SEQ_EMAIL_CONTATO
  START WITH 1
  INCREMENT BY 1
  MINVALUE 0
  MAXVALUE 1000
  NOCYCLE;
--------------------------------------------------------------------
CREATE TABLE T_TC_LOGIN(
  id_login NUMERIC NOT NULL,
  nr_cnpj NUMERIC NOT NULL,
  varchar_senha NUMERIC NOT NULL,
  id_cadastro NUMERIC NOT NULL,
  CONSTRAINT T_TC_LOGIN_PK PRIMARY KEY (id_login),
  CONSTRAINT T_TC_CADASTRO_LOGIN_FK FOREIGN KEY (id_cadastro) REFERENCES T_TC_CADASTRO(id_cadastro)
);

CREATE SEQUENCE SEQ_LOGIN
  START WITH 1
  INCREMENT BY 1
  MINVALUE 0
  MAXVALUE 1000
  NOCYCLE;
-------------------------------------------------------------------
CREATE TABLE T_TC_ENDERECO_EMPRESA(
  id_endereco NUMERIC NOT NULL,
  nr_logradouro NUMERIC NOT NULL,
  cep NUMERIC NOT NULL,
  ds_ponto_de_referencia VARCHAR(100) NOT NULL,
  id_cadastro NUMERIC NOT NULL,
  CONSTRAINT T_TC_ENDERECO_EMPRESA_PK PRIMARY KEY (id_endereco),
  CONSTRAINT T_TC_CADASTRO_ENDERECO_EMPRESA_FK FOREIGN KEY (id_cadastro) REFERENCES T_TC_CADASTRO(id_cadastro)
);

CREATE SEQUENCE SEQ_ENDERECO_EMPRESA
  START WITH 1
  INCREMENT BY 1
  MINVALUE 0
  MAXVALUE 1000
  NOCYCLE;
--------------------------------------------------------------------
CREATE TABLE T_TC_TELEFONE_EMPRESA(
  id_telefone NUMERIC NOT NULL,
  nr_ddi NUMERIC NOT NULL,
  nr_ddd NUMERIC NOT NULL,
  nr_telefone NUMERIC NOT NULL,
  tp_telefone VARCHAR(20) NOT NULL,
  id_cadastro NUMERIC NOT NULL,
  CONSTRAINT T_TC_TELEFONE_EMPRESA_PK PRIMARY KEY (id_telefone),
  CONSTRAINT T_TC_CADASTRO_TELEFONE_EMPRESA_FK FOREIGN KEY (id_cadastro) REFERENCES T_TC_CADASTRO(id_cadastro)
);

CREATE SEQUENCE SEQ_TELEFONE_EMPRESA
  START WITH 1
  INCREMENT BY 1
  MINVALUE 0
  MAXVALUE 1000
  NOCYCLE;
--------------------------------------------------------------------
CREATE TABLE T_TC_CONSULTA(
  id_consulta NUMERIC NOT NULL,
  ds_consulta VARCHAR(80) NOT NULL,
  dt_consulta DATE NOT NULL,
  blob_csv_arquivo BLOB NOT NULL,
  id_cadastro NUMERIC NOT NULL,
  CONSTRAINT T_TC_CONSULTA_PK PRIMARY KEY (id_consulta),
  CONSTRAINT T_TC_CADASTRO_CONSULTA_FK FOREIGN KEY (id_cadastro) REFERENCES T_TC_CADASTRO(id_cadastro)
);

CREATE SEQUENCE SEQ_CONSULTA
  START WITH 1
  INCREMENT BY 1
  MINVALUE 0
  MAXVALUE 1000
  NOCYCLE;
--------------------------------------------------------------------
CREATE TABLE T_TC_REPRESENTANTE(
  id_representante NUMERIC NOT NULL,
  nm_representante VARCHAR(80) NOT NULL,
  id_consulta NUMERIC NOT NULL,
  CONSTRAINT T_TC_REPRESENTANTE_PK PRIMARY KEY (id_representante),
  CONSTRAINT T_TC_CONSULTA_REPRESENTANTE_FK FOREIGN KEY (id_consulta) REFERENCES T_TC_CONSULTA(id_consulta)
);

CREATE SEQUENCE SEQ_REPRESENTANTE
  START WITH 1
  INCREMENT BY 1
  MINVALUE 0
  MAXVALUE 1000
  NOCYCLE;
--------------------------------------------------------------------
CREATE TABLE T_TC_ANALISE_DA_CONSULTA(
  id_analise_da_consulta NUMERIC NOT NULL,
  pdf_analise_da_consulta BLOB NOT NULL,
  st_analise_da_consulta char(1) check(st_analise_da_consulta in ('i', 'a')),
  id_consulta NUMERIC NOT NULL,
  CONSTRAINT T_TC_ANALISE_DA_CONSULTA_PK PRIMARY KEY (id_analise_da_consulta),
  CONSTRAINT T_TC_CONSULTA_ANALISE_DA_CONSULTA_FK FOREIGN KEY (id_consulta) REFERENCES T_TC_CONSULTA(id_consulta)
);

CREATE SEQUENCE SEQ_ANALISE_DA_CONSULTA
  START WITH 1
  INCREMENT BY 1
  MINVALUE 0
  MAXVALUE 1000
  NOCYCLE;
--------------------------------------------------------------------

INSERT INTO T_TC_CADASTRO (id_cadastro, nr_cnpj, varchar_senha, nm_razaosocial) VALUES (SEQ_CADASTRO.NEXTVAL, 12345678901234, 'senha123', 'Empresa A');
INSERT INTO T_TC_CADASTRO (id_cadastro, nr_cnpj, varchar_senha, nm_razaosocial) VALUES (SEQ_CADASTRO.NEXTVAL, 23456789012345, 'senha234', 'Empresa B');
INSERT INTO T_TC_CADASTRO (id_cadastro, nr_cnpj, varchar_senha, nm_razaosocial) VALUES (SEQ_CADASTRO.NEXTVAL, 34567890123456, 'senha345', 'Empresa C');
INSERT INTO T_TC_CADASTRO (id_cadastro, nr_cnpj, varchar_senha, nm_razaosocial) VALUES (SEQ_CADASTRO.NEXTVAL, 45678901234567, 'senha456', 'Empresa D');
INSERT INTO T_TC_CADASTRO (id_cadastro, nr_cnpj, varchar_senha, nm_razaosocial) VALUES (SEQ_CADASTRO.NEXTVAL, 56789012345678, 'senha567', 'Empresa E');

--------------------------------------------------------------------

INSERT INTO T_TC_EMAIL_CONTATO (id_email_contato, varchar_email, id_cadastro) VALUES (SEQ_EMAIL_CONTATO.NEXTVAL, 'email@empresaA.com', 1);
INSERT INTO T_TC_EMAIL_CONTATO (id_email_contato, varchar_email, id_cadastro) VALUES (SEQ_EMAIL_CONTATO.NEXTVAL, 'email@empresaB.com', 2);
INSERT INTO T_TC_EMAIL_CONTATO (id_email_contato, varchar_email, id_cadastro) VALUES (SEQ_EMAIL_CONTATO.NEXTVAL, 'email@empresaC.com', 3);
INSERT INTO T_TC_EMAIL_CONTATO (id_email_contato, varchar_email, id_cadastro) VALUES (SEQ_EMAIL_CONTATO.NEXTVAL, 'email@empresaD.com', 4);
INSERT INTO T_TC_EMAIL_CONTATO (id_email_contato, varchar_email, id_cadastro) VALUES (SEQ_EMAIL_CONTATO.NEXTVAL, 'email@empresaE.com', 5);

--------------------------------------------------------------------

INSERT INTO T_TC_LOGIN (id_login, nr_cnpj, varchar_senha, id_cadastro) VALUES (SEQ_LOGIN.NEXTVAL, 12345678901234, 123, 1);
INSERT INTO T_TC_LOGIN (id_login, nr_cnpj, varchar_senha, id_cadastro) VALUES (SEQ_LOGIN.NEXTVAL, 23456789012345, 234, 2);
INSERT INTO T_TC_LOGIN (id_login, nr_cnpj, varchar_senha, id_cadastro) VALUES (SEQ_LOGIN.NEXTVAL, 34567890123456, 345, 3);
INSERT INTO T_TC_LOGIN (id_login, nr_cnpj, varchar_senha, id_cadastro) VALUES (SEQ_LOGIN.NEXTVAL, 45678901234567, 456, 4);
INSERT INTO T_TC_LOGIN (id_login, nr_cnpj, varchar_senha, id_cadastro) VALUES (SEQ_LOGIN.NEXTVAL, 56789012345678, 567, 5);

--------------------------------------------------------------------

INSERT INTO T_TC_ENDERECO_EMPRESA (id_endereco, nr_logradouro, cep, ds_ponto_de_referencia, id_cadastro) VALUES (SEQ_ENDERECO_EMPRESA.NEXTVAL, 123, 12345678, 'Próximo ao mercado central', 1);
INSERT INTO T_TC_ENDERECO_EMPRESA (id_endereco, nr_logradouro, cep, ds_ponto_de_referencia, id_cadastro) VALUES (SEQ_ENDERECO_EMPRESA.NEXTVAL, 234, 23456789, 'Ao lado da estação de trem',2);
INSERT INTO T_TC_ENDERECO_EMPRESA (id_endereco, nr_logradouro, cep, ds_ponto_de_referencia, id_cadastro) VALUES (SEQ_ENDERECO_EMPRESA.NEXTVAL, 345, 34567890, 'Atrás do shopping novo', 3);
INSERT INTO T_TC_ENDERECO_EMPRESA (id_endereco, nr_logradouro, cep, ds_ponto_de_referencia, id_cadastro) VALUES (SEQ_ENDERECO_EMPRESA.NEXTVAL, 456, 45678901, 'Em frente ao parque da cidade', 4);
INSERT INTO T_TC_ENDERECO_EMPRESA (id_endereco, nr_logradouro, cep, ds_ponto_de_referencia, id_cadastro) VALUES (SEQ_ENDERECO_EMPRESA.NEXTVAL, 567, 56789012, 'Lado sul da universidade', 5);
--------------------------------------------------------------------

INSERT INTO T_TC_TELEFONE_EMPRESA (id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, id_cadastro) VALUES (SEQ_TELEFONE_EMPRESA.NEXTVAL, 55, 11, 12345678, 'Fixo', 1);
INSERT INTO T_TC_TELEFONE_EMPRESA (id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, id_cadastro) VALUES (SEQ_TELEFONE_EMPRESA.NEXTVAL, 55, 21, 23456789, 'Fixo', 2);
INSERT INTO T_TC_TELEFONE_EMPRESA (id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, id_cadastro) VALUES (SEQ_TELEFONE_EMPRESA.NEXTVAL, 55, 31, 34567890, 'Móvel', 3);
INSERT INTO T_TC_TELEFONE_EMPRESA (id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, id_cadastro) VALUES (SEQ_TELEFONE_EMPRESA.NEXTVAL, 55, 41, 45678901, 'Móvel', 4);
INSERT INTO T_TC_TELEFONE_EMPRESA (id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, id_cadastro) VALUES (SEQ_TELEFONE_EMPRESA.NEXTVAL, 55, 51, 56789012, 'Fax', 5);

--------------------------------------------------------------------
INSERT INTO T_TC_CONSULTA (id_consulta, ds_consulta, dt_consulta, blob_csv_arquivo, id_cadastro) VALUES (SEQ_CONSULTA.NEXTVAL, 'Consulta sobre impostos', '29/10/02', HEXTORAW('48656C6C6F'), 1);
INSERT INTO T_TC_CONSULTA (id_consulta, ds_consulta, dt_consulta, blob_csv_arquivo, id_cadastro) VALUES (SEQ_CONSULTA.NEXTVAL, 'Consulta sobre exportação', '29/10/02', HEXTORAW('48656C6C6F'), 2);
INSERT INTO T_TC_CONSULTA (id_consulta, ds_consulta, dt_consulta, blob_csv_arquivo, id_cadastro) VALUES (SEQ_CONSULTA.NEXTVAL, 'Consulta sobre importação', '29/10/02', HEXTORAW('48656C6C6F'), 3);
INSERT INTO T_TC_CONSULTA (id_consulta, ds_consulta, dt_consulta, blob_csv_arquivo, id_cadastro) VALUES (SEQ_CONSULTA.NEXTVAL, 'Consulta sobre regulamentação', '29/10/02', HEXTORAW('48656C6C6F'), 4);
INSERT INTO T_TC_CONSULTA (id_consulta, ds_consulta, dt_consulta, blob_csv_arquivo, id_cadastro) VALUES (SEQ_CONSULTA.NEXTVAL, 'Consulta sobre inovação', '29/10/02', HEXTORAW('48656C6C6F'), 5);
--------------------------------------------------------------------

INSERT INTO T_TC_REPRESENTANTE (id_representante, nm_representante, id_consulta) VALUES (SEQ_REPRESENTANTE.NEXTVAL, 'Representante A', 1);
INSERT INTO T_TC_REPRESENTANTE (id_representante, nm_representante, id_consulta) VALUES (SEQ_REPRESENTANTE.NEXTVAL, 'Representante B', 2);
INSERT INTO T_TC_REPRESENTANTE (id_representante, nm_representante, id_consulta) VALUES (SEQ_REPRESENTANTE.NEXTVAL, 'Representante C', 3);
INSERT INTO T_TC_REPRESENTANTE (id_representante, nm_representante, id_consulta) VALUES (SEQ_REPRESENTANTE.NEXTVAL, 'Representante D', 4);
INSERT INTO T_TC_REPRESENTANTE (id_representante, nm_representante, id_consulta) VALUES (SEQ_REPRESENTANTE.NEXTVAL, 'Representante E', 5);
--------------------------------------------------------------------

INSERT INTO T_TC_ANALISE_DA_CONSULTA (id_analise_da_consulta, pdf_analise_da_consulta, st_analise_da_consulta, id_consulta)VALUES (1, HEXTORAW('48656C6C6F'), 'i', 1);
INSERT INTO T_TC_ANALISE_DA_CONSULTA (id_analise_da_consulta, pdf_analise_da_consulta, st_analise_da_consulta, id_consulta)VALUES (2, HEXTORAW('48656C6C6F'), 'a', 2);
INSERT INTO T_TC_ANALISE_DA_CONSULTA (id_analise_da_consulta, pdf_analise_da_consulta, st_analise_da_consulta, id_consulta)VALUES (3, HEXTORAW('48656C6C6F'), 'i', 3);
INSERT INTO T_TC_ANALISE_DA_CONSULTA (id_analise_da_consulta, pdf_analise_da_consulta, st_analise_da_consulta, id_consulta)VALUES (4, HEXTORAW('48656C6C6F'), 'a', 4);
INSERT INTO T_TC_ANALISE_DA_CONSULTA (id_analise_da_consulta, pdf_analise_da_consulta, st_analise_da_consulta, id_consulta)VALUES (5, HEXTORAW('48656C6C6F'), 'i', 5);

--------------------------------------------------------------------
select * from t_tc_analise_da_consulta;
select * from t_tc_cadastro;
select * from t_tc_consulta;
select * from t_tc_email_contato;
select * from t_tc_endereco_empresa;
select * from t_tc_login;
select * from t_tc_representante;
select * from t_tc_telefone_empresa;
--------------------------------------------------------------------
set serveroutput on
SET VERIFY OFF

BEGIN
    FOR r IN (
        SELECT cad.nm_razaosocial, COUNT(e.id_email_contato) AS num_emails
        FROM T_TC_CADASTRO cad
        JOIN T_TC_EMAIL_CONTATO e ON cad.id_cadastro = e.id_cadastro
        GROUP BY cad.nm_razaosocial
        ORDER BY cad.nm_razaosocial ASC
    ) LOOP
        DBMS_OUTPUT.PUT_LINE(r.nm_razaosocial || ': ' || r.num_emails);
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('----------');
    
    FOR r IN (
        SELECT cad.nm_razaosocial, COUNT(cons.id_consulta) AS num_consultas
        FROM T_TC_CADASTRO cad
        JOIN T_TC_CONSULTA cons ON cad.id_cadastro = cons.id_cadastro
        GROUP BY cad.nm_razaosocial
        ORDER BY num_consultas DESC
    ) LOOP
        DBMS_OUTPUT.PUT_LINE(r.nm_razaosocial || ': ' || r.num_consultas);
    END LOOP;
END;
--------------------------------------------------------------------
BEGIN
    FOR r IN (
        SELECT e.cep, COUNT(cad.id_cadastro) AS num_empresas
        FROM T_TC_CADASTRO cad
        JOIN T_TC_ENDERECO_EMPRESA e ON cad.id_cadastro = e.id_cadastro
        GROUP BY e.cep
        ORDER BY num_empresas DESC
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('CEP: ' || r.cep || ' - Empresas: ' || r.num_empresas);
    END LOOP;
    
END;

--------------------------------------------------------------------
------------------------------SPRINT 2------------------------------
--------------------------------------------------------------------

------------------------------FUNCTIONS-----------------------------

CREATE OR REPLACE FUNCTION valida_telefone(nr_ddi IN NUMERIC, nr_ddd IN NUMERIC, nr_telefone IN NUMERIC) RETURN BOOLEAN IS
BEGIN
  IF nr_ddi != 55 THEN 
    RETURN FALSE;
  END IF;

  IF LENGTH(nr_ddd) != 2 THEN
    RETURN FALSE;
  END IF;

  IF LENGTH(nr_telefone) != 8 AND LENGTH(nr_telefone) != 9 THEN
    RETURN FALSE;
  END IF;

  RETURN TRUE;
END;
---

DECLARE
  resultado BOOLEAN;
BEGIN
resultado := valida_telefone(55, 11, 98765432);  
  IF resultado = TRUE THEN
    DBMS_OUTPUT.PUT_LINE('O telefone é válido.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('O telefone é inválido.');
  END IF;
END;

------

CREATE OR REPLACE FUNCTION verifica_tamanho_senha(senha IN VARCHAR2) RETURN BOOLEAN IS
BEGIN
  IF LENGTH(senha) <= 60 THEN
    RETURN TRUE;
  ELSE
    RETURN FALSE; 
  END IF;
END;

---

DECLARE
  resultado BOOLEAN;
BEGIN
  resultado := verifica_tamanho_senha('Senha123');
  
  IF resultado THEN
    DBMS_OUTPUT.PUT_LINE('A senha está dentro do limite de tamanho.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('A senha excede o limite de tamanho.');
  END IF;
END;

---------------------------------------------------------------------
----------------PROCEDURES - INSERT/UPDATE E DELETE------------------

---CADASTRO
CREATE OR REPLACE PROCEDURE SP_INSERT_CADASTRO(
    P_NR_CNPJ NUMERIC,
    P_SENHA VARCHAR,
    P_RAZAOSOCIAL VARCHAR
)
AS
BEGIN
    INSERT INTO T_TC_CADASTRO (id_cadastro, nr_cnpj, varchar_senha, nm_razaosocial)
    VALUES (SEQ_CADASTRO.NEXTVAL, P_NR_CNPJ, P_SENHA, P_RAZAOSOCIAL);
END;
---
CREATE OR REPLACE PROCEDURE SP_UPDATE_CADASTRO(
    P_ID_CADASTRO NUMERIC,
    P_NR_CNPJ NUMERIC,
    P_SENHA VARCHAR,
    P_RAZAOSOCIAL VARCHAR
)
AS
BEGIN
    UPDATE T_TC_CADASTRO
    SET nr_cnpj = P_NR_CNPJ,
        varchar_senha = P_SENHA,
        nm_razaosocial = P_RAZAOSOCIAL
    WHERE id_cadastro = P_ID_CADASTRO;
END;
---
CREATE OR REPLACE PROCEDURE SP_DELETE_CADASTRO(
    P_ID_CADASTRO NUMERIC
)
AS
BEGIN
    DELETE FROM T_TC_CADASTRO
    WHERE id_cadastro = P_ID_CADASTRO;
END;
---


---EMAIL_CONTATO
CREATE OR REPLACE PROCEDURE SP_INSERT_EMAIL_CONTATO(
    P_EMAIL VARCHAR,
    P_ID_CADASTRO NUMERIC
)
AS
BEGIN
    INSERT INTO T_TC_EMAIL_CONTATO (id_email_contato, varchar_email, id_cadastro)
    VALUES (SEQ_EMAIL_CONTATO.NEXTVAL, P_EMAIL, P_ID_CADASTRO);
END;
---
CREATE OR REPLACE PROCEDURE SP_UPDATE_EMAIL_CONTATO(
    P_ID_EMAIL_CONTATO NUMERIC,
    P_EMAIL VARCHAR,
    P_ID_CADASTRO NUMERIC
)
AS
BEGIN
    UPDATE T_TC_EMAIL_CONTATO
    SET varchar_email = P_EMAIL,
        id_cadastro = P_ID_CADASTRO
    WHERE id_email_contato = P_ID_EMAIL_CONTATO;
END;
---
CREATE OR REPLACE PROCEDURE SP_DELETE_EMAIL_CONTATO(
    P_ID_EMAIL_CONTATO NUMERIC
)
AS
BEGIN
    DELETE FROM T_TC_EMAIL_CONTATO
    WHERE id_email_contato = P_ID_EMAIL_CONTATO;
END;
---


---LOGIN
CREATE OR REPLACE PROCEDURE SP_INSERT_LOGIN(
    P_NR_CNPJ NUMERIC,
    P_SENHA VARCHAR,
    P_ID_CADASTRO NUMERIC
)
AS
BEGIN
    INSERT INTO T_TC_LOGIN (id_login, nr_cnpj, varchar_senha, id_cadastro)
    VALUES (SEQ_LOGIN.NEXTVAL, P_NR_CNPJ, P_SENHA, P_ID_CADASTRO);
END;
---
CREATE OR REPLACE PROCEDURE SP_UPDATE_LOGIN(
    P_ID_LOGIN NUMERIC,
    P_NR_CNPJ NUMERIC,
    P_SENHA VARCHAR,
    P_ID_CADASTRO NUMERIC
)
AS
BEGIN
    UPDATE T_TC_LOGIN
    SET nr_cnpj = P_NR_CNPJ,
        varchar_senha = P_SENHA,
        id_cadastro = P_ID_CADASTRO
    WHERE id_login = P_ID_LOGIN;
END;
---
CREATE OR REPLACE PROCEDURE SP_DELETE_LOGIN(
    P_ID_LOGIN NUMERIC
)
AS
BEGIN
    DELETE FROM T_TC_LOGIN
    WHERE id_login = P_ID_LOGIN;
END;
---


---ENDERECO_EMPRESA
CREATE OR REPLACE PROCEDURE SP_INSERT_ENDERECO_EMPRESA(
    P_NR_LOGRADOURO NUMERIC,
    P_CEP NUMERIC,
    P_DS_PONTO_REFERENCIA VARCHAR,
    P_ID_CADASTRO NUMERIC
)
AS
BEGIN
    INSERT INTO T_TC_ENDERECO_EMPRESA (id_endereco, nr_logradouro, cep, ds_ponto_de_referencia, id_cadastro)
    VALUES (SEQ_ENDERECO_EMPRESA.NEXTVAL, P_NR_LOGRADOURO, P_CEP, P_DS_PONTO_REFERENCIA, P_ID_CADASTRO);
END;
---
CREATE OR REPLACE PROCEDURE SP_UPDATE_ENDERECO_EMPRESA(
    P_ID_ENDERECO NUMERIC,
    P_NR_LOGRADOURO NUMERIC,
    P_CEP NUMERIC,
    P_DS_PONTO_REFERENCIA VARCHAR,
    P_ID_CADASTRO NUMERIC
)
AS
BEGIN
    UPDATE T_TC_ENDERECO_EMPRESA
    SET nr_logradouro = P_NR_LOGRADOURO,
        cep = P_CEP,
        ds_ponto_de_referencia = P_DS_PONTO_REFERENCIA,
        id_cadastro = P_ID_CADASTRO
    WHERE id_endereco = P_ID_ENDERECO;
END;
---
CREATE OR REPLACE PROCEDURE SP_DELETE_ENDERECO_EMPRESA(
    P_ID_ENDERECO NUMERIC
)
AS
BEGIN
    DELETE FROM T_TC_ENDERECO_EMPRESA
    WHERE id_endereco = P_ID_ENDERECO;
END;
---

---TELEFONE_EMPRESA
CREATE OR REPLACE PROCEDURE SP_INSERT_TELEFONE_EMPRESA(
    P_NR_DDI NUMERIC,
    P_NR_DDD NUMERIC,
    P_NR_TELEFONE NUMERIC,
    P_TP_TELEFONE VARCHAR,
    P_ID_CADASTRO NUMERIC
)
AS
BEGIN
    INSERT INTO T_TC_TELEFONE_EMPRESA (id_telefone, nr_ddi, nr_ddd, nr_telefone, tp_telefone, id_cadastro)
    VALUES (SEQ_TELEFONE_EMPRESA.NEXTVAL, P_NR_DDI, P_NR_DDD, P_NR_TELEFONE, P_TP_TELEFONE, P_ID_CADASTRO);
END;
---
CREATE OR REPLACE PROCEDURE SP_UPDATE_TELEFONE_EMPRESA(
    P_ID_TELEFONE NUMERIC,
    P_NR_DDI NUMERIC,
    P_NR_DDD NUMERIC,
    P_NR_TELEFONE NUMERIC,
    P_TP_TELEFONE VARCHAR,
    P_ID_CADASTRO NUMERIC
)
AS
BEGIN
    UPDATE T_TC_TELEFONE_EMPRESA
    SET nr_ddi = P_NR_DDI,
        nr_ddd = P_NR_DDD,
        nr_telefone = P_NR_TELEFONE,
        tp_telefone = P_TP_TELEFONE,
        id_cadastro = P_ID_CADASTRO
    WHERE id_telefone = P_ID_TELEFONE;
END;
---
CREATE OR REPLACE PROCEDURE SP_DELETE_TELEFONE_EMPRESA(
    P_ID_TELEFONE NUMERIC
)
AS
BEGIN
    DELETE FROM T_TC_TELEFONE_EMPRESA
    WHERE id_telefone = P_ID_TELEFONE;
END;
---


---CONSULTA
CREATE OR REPLACE PROCEDURE SP_INSERT_CONSULTA(
    P_DS_CONSULTA VARCHAR,
    P_DT_CONSULTA DATE,
    P_BLOB_CSV_ARQUIVO BLOB,
    P_ID_CADASTRO NUMERIC
)
AS
BEGIN
    INSERT INTO T_TC_CONSULTA (id_consulta, ds_consulta, dt_consulta, blob_csv_arquivo, id_cadastro)
    VALUES (SEQ_CONSULTA.NEXTVAL, P_DS_CONSULTA, P_DT_CONSULTA, P_BLOB_CSV_ARQUIVO, P_ID_CADASTRO);
END;
---
CREATE OR REPLACE PROCEDURE SP_UPDATE_CONSULTA(
    P_ID_CONSULTA NUMERIC,
    P_DS_CONSULTA VARCHAR,
    P_DT_CONSULTA DATE,
    P_BLOB_CSV_ARQUIVO BLOB,
    P_ID_CADASTRO NUMERIC
)
AS
BEGIN
    UPDATE T_TC_CONSULTA
    SET ds_consulta = P_DS_CONSULTA,
        dt_consulta = P_DT_CONSULTA,
        blob_csv_arquivo = P_BLOB_CSV_ARQUIVO,
        id_cadastro = P_ID_CADASTRO
    WHERE id_consulta = P_ID_CONSULTA;
END;
---
CREATE OR REPLACE PROCEDURE SP_DELETE_CONSULTA(
    P_ID_CONSULTA NUMERIC
)
AS
BEGIN
    DELETE FROM T_TC_CONSULTA
    WHERE id_consulta = P_ID_CONSULTA;
END;
---


---REPRESENTANTE
CREATE OR REPLACE PROCEDURE SP_INSERT_REPRESENTANTE(
    P_NM_REPRESENTANTE VARCHAR,
    P_ID_CONSULTA NUMERIC
)
AS
BEGIN
    INSERT INTO T_TC_REPRESENTANTE (id_representante, nm_representante, id_consulta)
    VALUES (SEQ_REPRESENTANTE.NEXTVAL, P_NM_REPRESENTANTE, P_ID_CONSULTA);
END;
---
CREATE OR REPLACE PROCEDURE SP_UPDATE_REPRESENTANTE(
    P_ID_REPRESENTANTE NUMERIC,
    P_NM_REPRESENTANTE VARCHAR,
    P_ID_CONSULTA NUMERIC
)
AS
BEGIN
    UPDATE T_TC_REPRESENTANTE
    SET nm_representante = P_NM_REPRESENTANTE,
        id_consulta = P_ID_CONSULTA
    WHERE id_representante = P_ID_REPRESENTANTE;
END;
---
CREATE OR REPLACE PROCEDURE SP_DELETE_REPRESENTANTE(
    P_ID_REPRESENTANTE NUMERIC
)
AS
BEGIN
    DELETE FROM T_TC_REPRESENTANTE
    WHERE id_representante = P_ID_REPRESENTANTE;
END;
---


---ANALISE_DA_CONSULTA
CREATE OR REPLACE PROCEDURE SP_INSERT_ANALISE_DA_CONSULTA(
    P_PDF_ANALISE_DA_CONSULTA BLOB,
    P_ST_ANALISE_DA_CONSULTA CHAR,
    P_ID_CONSULTA NUMERIC
)
AS
BEGIN
    INSERT INTO T_TC_ANALISE_DA_CONSULTA (id_analise_da_consulta, pdf_analise_da_consulta, st_analise_da_consulta, id_consulta)
    VALUES (SEQ_ANALISE_DA_CONSULTA.NEXTVAL, P_PDF_ANALISE_DA_CONSULTA, P_ST_ANALISE_DA_CONSULTA, P_ID_CONSULTA);
END;
---
CREATE OR REPLACE PROCEDURE SP_UPDATE_ANALISE_DA_CONSULTA(
    P_ID_ANALISE_DA_CONSULTA NUMERIC,
    P_PDF_ANALISE_DA_CONSULTA BLOB,
    P_ST_ANALISE_DA_CONSULTA CHAR,
    P_ID_CONSULTA NUMERIC
)
AS
BEGIN
    UPDATE T_TC_ANALISE_DA_CONSULTA
    SET pdf_analise_da_consulta = P_PDF_ANALISE_DA_CONSULTA,
        st_analise_da_consulta = P_ST_ANALISE_DA_CONSULTA,
        id_consulta = P_ID_CONSULTA
    WHERE id_analise_da_consulta = P_ID_ANALISE_DA_CONSULTA;
END;
---
CREATE OR REPLACE PROCEDURE SP_DELETE_ANALISE_DA_CONSULTA(
    P_ID_ANALISE_DA_CONSULTA NUMERIC
)
AS
BEGIN
    DELETE FROM T_TC_ANALISE_DA_CONSULTA
    WHERE id_analise_da_consulta = P_ID_ANALISE_DA_CONSULTA;
END;
---

---------------------------------------------------------------------
-------------------------PROCEDURES - JOIN---------------------------
SET SERVEROUTPUT ON;
SET VERIFY OFF;


CREATE OR REPLACE PROCEDURE SP_CONSULTAS_DETALHADAS AS
CURSOR CUR_CONSULTAS_DETALHADAS IS
    SELECT c.ds_consulta, c.dt_consulta, r.nm_representante, cad.nm_razaosocial
    FROM T_TC_CONSULTA c
    JOIN T_TC_REPRESENTANTE r ON c.id_consulta = r.id_consulta
    JOIN T_TC_CADASTRO cad ON c.id_cadastro = cad.id_cadastro;
BEGIN
    FOR REGISTRO IN CUR_CONSULTAS_DETALHADAS LOOP
        DBMS_OUTPUT.PUT_LINE('Consulta: ' || REGISTRO.ds_consulta || 
                             ', Data: ' || REGISTRO.dt_consulta || 
                             ', Representante: ' || REGISTRO.nm_representante || 
                             ', Empresa: ' || REGISTRO.nm_razaosocial);
    END LOOP;
END;

EXEC SP_CONSULTAS_DETALHADAS;
