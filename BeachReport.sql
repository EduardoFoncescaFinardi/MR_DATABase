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
    nr_cpf NUMBER UNIQUE,
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
    nr_likes NUMBER,
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
set verify off
set serveroutput on

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
        NULL; 
END;

BEGIN
    PRC_INSERIR_LOG_ERRO(
        p_nome_procedure => 'PRC_INSERIR_USUARIO',
        p_nome_usuario => USER,
        p_codigo_erro => -20001,
        p_mensagem_erro => 'Erro de teste'
    );
END;

select * from T_BR_LOG_ERROS;
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
----
---- teste válido
BEGIN
    PRC_INSERIR_USUARIO(p_nr_cpf => 12345678901, p_varchar_senha => 'senha123');
END;
----
---- teste EXCEPTION
BEGIN
    PRC_INSERIR_USUARIO(p_nr_cpf => 12345678901, p_varchar_senha => 'senha123');
    PRC_INSERIR_USUARIO(p_nr_cpf => 12345678901, p_varchar_senha => 'senha124');
END;
---- TESTE EXTRA
SELECT object_name, status
FROM user_objects
WHERE object_type = 'PROCEDURE'
AND object_name = 'PRC_INSERIR_LOG_ERRO';
----
----
select * from T_BR_USUARIO;
select * from T_BR_LOG_ERROS;
---


--- T_BR_ENDERCO_USUSARIO
CREATE OR REPLACE PROCEDURE PRC_INSERIR_ENDERECO_USUARIO (
    p_nr_cep IN NUMBER,
    p_id_usuario IN NUMBER
) AS
BEGIN
    INSERT INTO T_BR_ENDERECO_USUARIO (
        id_endereco, nr_cep, id_usuario
    ) VALUES (
        SEQ_ENDERECO_USUARIO.NEXTVAL, p_nr_cep, p_id_usuario
    );
    COMMIT;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        PRC_INSERIR_LOG_ERRO('PRC_INSERIR_ENDERECO_USUARIO', USER, SQLCODE, SQLERRM);
        RAISE_APPLICATION_ERROR(-20002, 'Erro: Usuário não encontrado.');
    WHEN OTHERS THEN
        PRC_INSERIR_LOG_ERRO('PRC_INSERIR_ENDERECO_USUARIO', USER, SQLCODE, SQLERRM);
        RAISE;
END;
----
---- teste válido
BEGIN
    PRC_INSERIR_ENDERECO_USUARIO(p_nr_cep => 12345678, p_id_usuario => 1);
END;
----
---- teste EXCEPTION
BEGIN
    PRC_INSERIR_ENDERECO_USUARIO(p_nr_cep => 12345678, p_id_usuario => 9999); 
END;
----
select * from T_BR_ENDERECO_USUARIO;
select * from T_BR_LOG_ERROS;
----


---- T_BR_TELEFONE_USUSARIO
CREATE OR REPLACE PROCEDURE PRC_INSERIR_TELEFONE_USUARIO (
    p_nr_ddd IN NUMBER,
    p_nr_telefone IN NUMBER,
    p_id_usuario IN NUMBER
) AS
BEGIN
    INSERT INTO T_BR_TELEFONE_USUARIO (
        id_telefone, nr_ddd, nr_telefone, id_usuario
    ) VALUES (
        SEQ_TELEFONE_USUARIO.NEXTVAL, p_nr_ddd, p_nr_telefone, p_id_usuario
    );
    COMMIT;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        PRC_INSERIR_LOG_ERRO('PRC_INSERIR_TELEFONE_USUARIO', USER, SQLCODE, SQLERRM);
        RAISE_APPLICATION_ERROR(-20002, 'Erro: Usuário não encontrado.');
    WHEN OTHERS THEN
        PRC_INSERIR_LOG_ERRO('PRC_INSERIR_TELEFONE_USUARIO', USER, SQLCODE, SQLERRM);
        RAISE;
END;
----
---- teste válido
BEGIN
    PRC_INSERIR_TELEFONE_USUARIO(p_nr_ddd => 11, p_nr_telefone => 987654321, p_id_usuario => 1);
END;
----
---- teste EXCEPTION
BEGIN
    PRC_INSERIR_TELEFONE_USUARIO(p_nr_ddd => 11, p_nr_telefone => 987654321, p_id_usuario => 9999); 
END;
--- teste EXTRA
SELECT object_name, status
FROM user_objects
WHERE object_type = 'PROCEDURE'
AND object_name = 'PRC_INSERIR_LOG_ERRO';
----
select * from T_BR_TELEFONE_USUARIO;
select * from T_BR_LOG_ERROS;
----



---- T_BR_EMAIL_USUSARIO
CREATE OR REPLACE PROCEDURE PRC_INSERIR_EMAIL_USUARIO (
    p_varchar_email IN VARCHAR2,
    p_id_usuario IN NUMBER
) AS
BEGIN
    INSERT INTO T_BR_EMAIL_USUARIO (
        id_email_contato, varchar_email, id_usuario
    ) VALUES (
        SEQ_EMAIL_USUARIO.NEXTVAL, p_varchar_email, p_id_usuario
    );
    COMMIT;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        PRC_INSERIR_LOG_ERRO('PRC_INSERIR_EMAIL_USUARIO', USER, SQLCODE, SQLERRM);
        RAISE_APPLICATION_ERROR(-20002, 'Erro: Usuário não encontrado.');
    WHEN OTHERS THEN
        PRC_INSERIR_LOG_ERRO('PRC_INSERIR_EMAIL_USUARIO', USER, SQLCODE, SQLERRM);
        RAISE;
END;

----
---- teste válido
BEGIN
    PRC_INSERIR_EMAIL_USUARIO(p_varchar_email => 'usuario@exemplo.com', p_id_usuario => 1);
END;

----
---- teste EXCEPTION
BEGIN
    PRC_INSERIR_EMAIL_USUARIO(p_varchar_email => 'usuario@exemplo.com', p_id_usuario => 9999); -- id_usuario 9999 não existe
END;
---- teste EXTRA

----

select * from T_BR_EMAIL_USUARIO;
select * from T_BR_LOG_ERROS;
----



---- T_BR_NIVEL_CONFIABILIDADE
CREATE OR REPLACE PROCEDURE PRC_INSERIR_NIVEL_CONFIABILIDADE (
    p_numeric_nivel_confiabilidade IN NUMBER,
    p_id_usuario IN NUMBER
) AS
BEGIN
    INSERT INTO T_BR_NIVEL_CONFIABILIDADE (
        id_nivel_confiabilidade, numeric_nivel_confiabilidade, id_usuario
    ) VALUES (
        SEQ_NIVEL_CONFIABILIDADE.NEXTVAL, p_numeric_nivel_confiabilidade, p_id_usuario
    );
    COMMIT;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        PRC_INSERIR_LOG_ERRO('PRC_INSERIR_NIVEL_CONFIABILIDADE', USER, SQLCODE, SQLERRM);
        RAISE_APPLICATION_ERROR(-20002, 'Erro: Usuário não encontrado.');
    WHEN OTHERS THEN
        PRC_INSERIR_LOG_ERRO('PRC_INSERIR_NIVEL_CONFIABILIDADE', USER, SQLCODE, SQLERRM);
        RAISE;
END;
----
---- teste válido
BEGIN
    PRC_INSERIR_NIVEL_CONFIABILIDADE(p_numeric_nivel_confiabilidade => 5, p_id_usuario => 1);
END;
----
---- teste EXCEPTION
BEGIN
    PRC_INSERIR_NIVEL_CONFIABILIDADE(p_numeric_nivel_confiabilidade => 5, p_id_usuario => 9999); -- id_usuario 9999 não existe
END;
---- teste EXTRA

----
select * from T_BR_NIVEL_CONFIABILIDADE;
select * from T_BR_LOG_ERROS;
----



---- T_BR_RELATO
CREATE OR REPLACE PROCEDURE PRC_INSERIR_RELATO (
    p_blob_foto IN BLOB,
    p_ds_relato IN VARCHAR2,
    p_nr_latitude IN NUMBER,
    p_nr_longitude IN NUMBER,
    p_boolean_praia_suja IN NUMBER,
    p_boolean_envolve_animais IN NUMBER,
    p_id_usuario IN NUMBER,
    p_nr_likes IN NUMBER,
    p_dt_hr_relato IN DATE
) AS
BEGIN
    INSERT INTO T_BR_RELATO (
        id_relato, blob_foto, ds_relato, nr_latitude, nr_longitude, boolean_praia_suja, boolean_envolve_animais, id_usuario, nr_likes, dt_hr_relato
    ) VALUES (
        SEQ_RELATO.NEXTVAL, p_blob_foto, p_ds_relato, p_nr_latitude, p_nr_longitude, p_boolean_praia_suja, p_boolean_envolve_animais, p_id_usuario,p_nr_likes, p_dt_hr_relato
    );
    COMMIT;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        PRC_INSERIR_LOG_ERRO('PRC_INSERIR_RELATO', USER, SQLCODE, SQLERRM);
        RAISE_APPLICATION_ERROR(-20002, 'Erro: Usuário não encontrado.');
    WHEN OTHERS THEN
        PRC_INSERIR_LOG_ERRO('PRC_INSERIR_RELATO', USER, SQLCODE, SQLERRM);
        RAISE;
END;
----
---- teste válido
DECLARE
    v_blob_foto BLOB;
BEGIN
    DBMS_LOB.CREATETEMPORARY(v_blob_foto, TRUE);

    PRC_INSERIR_RELATO(
        p_blob_foto => v_blob_foto,
        p_ds_relato => 'Relato de exemplo',
        p_nr_latitude => -23.55052,
        p_nr_longitude => -46.633308,
        p_boolean_praia_suja => 1,
        p_boolean_envolve_animais => 0,
        p_id_usuario => 1,
        p_nr_likes => 10,
        p_dt_hr_relato => SYSDATE
    );

    DBMS_LOB.FREETEMPORARY(v_blob_foto);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_LOB.FREETEMPORARY(v_blob_foto);
        RAISE;
END;
----
---- teste EXCEPTION
DECLARE
    v_blob_foto BLOB;
BEGIN
    DBMS_LOB.CREATETEMPORARY(v_blob_foto, TRUE);

    PRC_INSERIR_RELATO(
        p_blob_foto => v_blob_foto,
        p_ds_relato => 'Relato de exemplo',
        p_nr_latitude => -23.55052,
        p_nr_longitude => -46.633308,
        p_boolean_praia_suja => 1,
        p_boolean_envolve_animais => 0,
        p_id_usuario => 9999, 
        p_nr_likes => 10,
        p_dt_hr_relato => SYSDATE
    );

    DBMS_LOB.FREETEMPORARY(v_blob_foto);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_LOB.FREETEMPORARY(v_blob_foto);
        RAISE;
END;
---- teste EXTRA

----
select * from T_BR_RELATO;
select * from T_BR_LOG_ERROS;

--------------------------------------------------------------------------------
--------------------------BLOCOS ANÔNIMOS - CURSOR------------------------------
set verify off
set serveroutput on

----
DECLARE
    CURSOR c_relato IS
        SELECT * FROM T_BR_RELATO;
    v_relato c_relato%ROWTYPE;
BEGIN
    OPEN c_relato;
    LOOP
        FETCH c_relato INTO v_relato;
        EXIT WHEN c_relato%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('ID: ' || v_relato.id_relato || ', Descrição: ' || v_relato.ds_relato || ', Latitude: ' || v_relato.nr_latitude || ', Longitude: ' || v_relato.nr_longitude);
    END LOOP;
    CLOSE c_relato;
END;
----



----
DECLARE
    CURSOR c_relato IS
        SELECT boolean_praia_suja FROM T_BR_RELATO;
    v_boolean_praia_suja T_BR_RELATO.boolean_praia_suja%TYPE;
    v_total_praia_suja NUMBER := 0;
    v_total_praia_nao_suja NUMBER := 0;
BEGIN
    OPEN c_relato;
    LOOP
        FETCH c_relato INTO v_boolean_praia_suja;
        EXIT WHEN c_relato%NOTFOUND;
        IF v_boolean_praia_suja = 1 THEN
            v_total_praia_suja := v_total_praia_suja + 1;
        ELSE
            v_total_praia_nao_suja := v_total_praia_nao_suja + 1;
        END IF;
    END LOOP;
    CLOSE c_relato;
    DBMS_OUTPUT.PUT_LINE('Total Praia Suja: ' || v_total_praia_suja);
    DBMS_OUTPUT.PUT_LINE('Total Praia Não Suja: ' || v_total_praia_nao_suja);
END;
----



----
DECLARE
    CURSOR c_relato IS
        SELECT boolean_envolve_animais FROM T_BR_RELATO;
    v_boolean_envolve_animais T_BR_RELATO.boolean_envolve_animais%TYPE;
    v_total_com_animais NUMBER := 0;
    v_total_sem_animais NUMBER := 0;
BEGIN
    OPEN c_relato;
    LOOP
        FETCH c_relato INTO v_boolean_envolve_animais;
        EXIT WHEN c_relato%NOTFOUND;
        IF v_boolean_envolve_animais = 1 THEN
            v_total_com_animais := v_total_com_animais + 1;
        ELSE
            v_total_sem_animais := v_total_sem_animais + 1;
        END IF;
    END LOOP;
    CLOSE c_relato;
    DBMS_OUTPUT.PUT_LINE('Total Casos com Animais: ' || v_total_com_animais);
    DBMS_OUTPUT.PUT_LINE('Total Casos sem Animais: ' || v_total_sem_animais);
END;
----


----
DECLARE
    CURSOR c_relato IS
        SELECT id_relato, blob_foto, ds_relato, nr_latitude, nr_longitude, boolean_praia_suja, boolean_envolve_animais, id_usuario, dt_hr_relato
        FROM T_BR_RELATO
        WHERE nr_latitude BETWEEN -23.6 AND -23.5
        ORDER BY nr_latitude;
    
    v_relato c_relato%ROWTYPE;
    v_total_praia_suja NUMBER := 0;
    v_total_praia_nao_suja NUMBER := 0;
    v_total_com_animais NUMBER := 0;
    v_total_sem_animais NUMBER := 0;
    v_current_latitude_interval NUMBER := NULL;
    v_interval_size NUMBER := 0.01; 
BEGIN
    OPEN c_relato;
    LOOP
        FETCH c_relato INTO v_relato;
        EXIT WHEN c_relato%NOTFOUND;

        IF v_current_latitude_interval IS NULL OR v_relato.nr_latitude >= v_current_latitude_interval + v_interval_size THEN
            IF v_current_latitude_interval IS NOT NULL THEN
                DBMS_OUTPUT.PUT_LINE('--- Fim do Intervalo de Latitude: ' || v_current_latitude_interval || ' a ' || (v_current_latitude_interval + v_interval_size));
                DBMS_OUTPUT.PUT_LINE('Total Praia Suja: ' || v_total_praia_suja);
                DBMS_OUTPUT.PUT_LINE('Total Praia Não Suja: ' || v_total_praia_nao_suja);
                DBMS_OUTPUT.PUT_LINE('Total Casos com Animais: ' || v_total_com_animais);
                DBMS_OUTPUT.PUT_LINE('Total Casos sem Animais: ' || v_total_sem_animais);
                DBMS_OUTPUT.PUT_LINE('----------------------------------------');
                v_total_praia_suja := 0;
                v_total_praia_nao_suja := 0;
                v_total_com_animais := 0;
                v_total_sem_animais := 0;
            END IF;
            v_current_latitude_interval := FLOOR(v_relato.nr_latitude / v_interval_size) * v_interval_size;
            DBMS_OUTPUT.PUT_LINE('--- Início do Intervalo de Latitude: ' || v_current_latitude_interval || ' a ' || (v_current_latitude_interval + v_interval_size));
        END IF;

        DBMS_OUTPUT.PUT_LINE('ID: ' || v_relato.id_relato || ', Descrição: ' || v_relato.ds_relato || ', Latitude: ' || v_relato.nr_latitude || ', Longitude: ' || v_relato.nr_longitude || ', Praia Suja: ' || v_relato.boolean_praia_suja || ', Envolve Animais: ' || v_relato.boolean_envolve_animais || ', Usuário: ' || v_relato.id_usuario || ', Data: ' || v_relato.dt_hr_relato);

        IF v_relato.boolean_praia_suja = 1 THEN
            v_total_praia_suja := v_total_praia_suja + 1;
        ELSE
            v_total_praia_nao_suja := v_total_praia_nao_suja + 1;
        END IF;

        IF v_relato.boolean_envolve_animais = 1 THEN
            v_total_com_animais := v_total_com_animais + 1;
        ELSE
            v_total_sem_animais := v_total_sem_animais + 1;
        END IF;
    END LOOP;

    IF v_current_latitude_interval IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('--- Fim do Intervalo de Latitude: ' || v_current_latitude_interval || ' a ' || (v_current_latitude_interval + v_interval_size));
        DBMS_OUTPUT.PUT_LINE('Total Praia Suja: ' || v_total_praia_suja);
        DBMS_OUTPUT.PUT_LINE('Total Praia Não Suja: ' || v_total_praia_nao_suja);
        DBMS_OUTPUT.PUT_LINE('Total Casos com Animais: ' || v_total_com_animais);
        DBMS_OUTPUT.PUT_LINE('Total Casos sem Animais: ' || v_total_sem_animais);
        DBMS_OUTPUT.PUT_LINE('----------------------------------------');
    END IF;

    CLOSE c_relato;
END;
