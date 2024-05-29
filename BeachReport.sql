------------------DROP-----------------------------------
DROP TABLE T_BR_ENDERECO_USUARIO;
DROP TABLE T_BR_TELEFONE_USUARIO;
DROP TABLE T_BR_NIVEL_CONFIABILIDADE;
DROP TABLE T_BR_RELATO;
DROP TABLE T_BR_EMAIL_USUARIO;
DROP TABLE T_BR_USUARIO;
DROP TABLE T_BR_LOG_ERROS;

DROP SEQUENCE SEQ_USUARIO;
DROP SEQUENCE SEQ_ENDERECO_USUARIO;
DROP SEQUENCE SEQ_TELEFONE_USUARIO;
DROP SEQUENCE SEQ_EMAIL_USUARIO;
DROP SEQUENCE SEQ_NIVEL_CONFIABILIDADE;
DROP SEQUENCE SEQ_RELATO;
DROP SEQUENCE SEQ_LOG_ERROS;

------------------CREATE---------------------------------
---------------------------------------------------------
CREATE TABLE T_BR_USUARIO(
    id_usuario NUMBER,
    nr_cpf NUMBER,
    varchar_senha VARCHAR(50),
    CONSTRAINT T_TB_USUARIO_PK PRIMARY KEY (id_usuario)
);

CREATE SEQUENCE SEQ_USUARIO
  START WITH 1
  INCREMENT BY 1
  MINVALUE 0
  MAXVALUE 1000
  NOCYCLE;
----------------------------------------------------------
CREATE TABLE T_BR_ENDERECO_USUARIO(
    id_endereco NUMBER,
    nr_cep NUMBER,
    id_usuario NUMBER,
    CONSTRAINT T_BR_ENDERECO_USUARIO_PK PRIMARY KEY (id_endereco),
    CONSTRAINT T_BR_ENDERECO_USUARIO_USUARIO_FK FOREIGN KEY (id_usuario) REFERENCES T_BR_USUARIO(id_usuario)
);

CREATE SEQUENCE SEQ_ENDERECO_USUARIO
  START WITH 1
  INCREMENT BY 1
  MINVALUE 0
  MAXVALUE 1000
  NOCYCLE;
----------------------------------------------------------
CREATE TABLE T_BR_TELEFONE_USUARIO(
    id_telefone NUMBER,
    nr_ddd NUMBER,
    nr_telefone NUMBER,
    id_usuario NUMBER,
    CONSTRAINT T_BR_TELEFONE_USUARIO_PK PRIMARY KEY (id_telefone),
    CONSTRAINT T_BR_TELEFONE_USUARIO_USUARIO_FK FOREIGN KEY (id_usuario) REFERENCES T_BR_USUARIO(id_usuario)
);

CREATE SEQUENCE SEQ_TELEFONE_USUARIO
  START WITH 1
  INCREMENT BY 1
  MINVALUE 0
  MAXVALUE 1000
  NOCYCLE;
----------------------------------------------------------
CREATE TABLE T_BR_EMAIL_USUARIO(
    id_email_contato NUMBER,
    varchar_email VARCHAR(80),
    id_usuario NUMBER,
    CONSTRAINT T_BR_EMAIL_USUARIO_PK PRIMARY KEY (id_email_contato),
    CONSTRAINT T_BR_EMAIL_USUARIO_USUARIO_FK FOREIGN KEY (id_usuario) REFERENCES T_BR_USUARIO(id_usuario)   
);

CREATE SEQUENCE SEQ_EMAIL_USUARIO
  START WITH 1
  INCREMENT BY 1
  MINVALUE 0
  MAXVALUE 1000
  NOCYCLE;
----------------------------------------------------------
CREATE TABLE T_BR_NIVEL_CONFIABILIDADE(
    id_nivel_confiabilidade NUMBER,
    numeric_nivel_confiabilidade NUMBER,
    id_usuario NUMBER,
    CONSTRAINT T_BR_NIVEL_CONFIABILIDADE_PK PRIMARY KEY (id_nivel_confiabilidade),
    CONSTRAINT T_BR_NIVEL_CONFIABILIDADE_USUARIO FOREIGN KEY (id_usuario) REFERENCES T_BR_USUARIO(id_usuario)   
);

CREATE SEQUENCE SEQ_NIVEL_CONFIABILIDADE
  START WITH 1
  INCREMENT BY 1
  MINVALUE 0
  MAXVALUE 1000
  NOCYCLE;
----------------------------------------------------------
CREATE TABLE T_BR_RELATO(
    id_relato NUMBER,
    blob_foto BLOB,
    ds_relato VARCHAR2(4000),
    nr_latitude NUMBER,
    nr_longitude NUMBER,
    boolean_praia_suja NUMBER(1), 
    boolean_envolve_animais NUMBER(1),
    dt_hr_relato DATE,
    id_usuario NUMBER,
    CONSTRAINT T_BR_RELATO_PK PRIMARY KEY (id_relato),
    CONSTRAINT T_BR_RELATO_USUARIO_FK FOREIGN KEY (id_usuario) REFERENCES T_BR_USUARIO(id_usuario)   
);

CREATE SEQUENCE SEQ_RELATO
  START WITH 1
  INCREMENT BY 1
  MINVALUE 0
  MAXVALUE 1000
  NOCYCLE;
----------------------------------------------------------
CREATE TABLE T_BR_LOG_ERROS(
    id_log NUMBER,
    nome_procedure VARCHAR(255),
    nome_usuario VARCHAR(255),
    data_ocorrencia DATE,
    codigo_erro NUMBER,
    mensagem_erro VARCHAR2(4000),
    CONSTRAINT T_BR_LOG_ERROS_PK PRIMARY KEY (id_log)
);

CREATE SEQUENCE SEQ_LOG_ERROS
  START WITH 1
  INCREMENT BY 1
  MINVALUE 0
  MAXVALUE 10000
  NOCYCLE;
  
----------------------------------------------------------------------------------
--------------------------PROCEDURE - CARGA DE DADOS------------------------------
---T_BR_LOG_ERRO
CREATE OR REPLACE PROCEDURE PRC_INSERIR_LOG_ERRO (
    p_nome_procedure IN VARCHAR2,
    p_nome_usuario IN VARCHAR2,
    p_codigo_erro IN NUMBER,
    p_mensagem_erro IN VARCHAR2
) AS
BEGIN
    INSERT INTO T_BR_LOG_ERROS (
        id_log, nome_procedure, nome_usuario, data_ocorrencia, codigo_erro, mensagem_erro
    ) VALUES (
        SEQ_LOG_ERROS.NEXTVAL, p_nome_procedure, p_nome_usuario, SYSDATE, p_codigo_erro, p_mensagem_erro
    );
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        NULL; -- Evitar loop infinito em caso de erro na inserção do log
END;
---

---T_BR_USUARIO
CREATE OR REPLACE PROCEDURE PRC_INSERIR_USUARIO (
    p_nr_cpf IN NUMBER,
    p_varchar_senha IN VARCHAR2
) AS
BEGIN
    INSERT INTO T_BR_USUARIO (
        id_usuario, nr_cpf, varchar_senha
    ) VALUES (
        SEQ_USUARIO.NEXTVAL, p_nr_cpf, p_varchar_senha
    );
    COMMIT;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        PRC_INSERIR_LOG_ERRO('PRC_INSERIR_USUARIO', USER, SQLCODE, SQLERRM);
        RAISE_APPLICATION_ERROR(-20001, 'Erro: CPF duplicado.');
    WHEN OTHERS THEN
        PRC_INSERIR_LOG_ERRO('PRC_INSERIR_USUARIO', USER, SQLCODE, SQLERRM);
        RAISE;
END;
