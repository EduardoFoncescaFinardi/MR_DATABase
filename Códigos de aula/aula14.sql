set serveroutput on
set verify off

CREATE OR REPLACE PACKAGE teste1
AS
disciplina VARCHAR2(20) := 'DB Application';
unidade VARCHAR(30) := 'FIAP - PAULISTA - MANHÃ';
END teste1;

DECLARE
concatena VARCHAR2(100);
BEGIN
concatena := teste1.disciplina || ', on FIAP';
dbms_output.put_line(concatena);
END;

--------------------------------------------------

DROP TABLE emp CASCADE CONSTRAINTS;
CREATE TABLE emp (empno NUMBER(3), sal NUMBER(8,2));

INSERT INTO emp VALUES (1,1000);

CREATE OR REPLACE PACKAGE rh 
as
    FUNCTION descobrir_salario (p_id IN emp.empno%TYPE) 
        RETURN NUMBER;
    PROCEDURE reajuste(v_codigo_emp IN emp.empno%TYPE,
                   v_porcentagem IN number DEFAULT 25);
END rh;


CREATE OR REPLACE PACKAGE BODY rh
AS
    FUNCTION descobrir_salario(p_id IN emp.empno%TYPE)
        RETURN NUMBER
        IS
            v_salario emp.sal%TYPE := 0;
        BEGIN
            SELECT sal INTO v_salario FROM emp WHERE empno = p_id;
            RETURN v_salario;
        END descobrir_salario;
    PROCEDURE reajuste(v_codigo_emp IN emp.empno%type,
                   v_porcentagem IN number DEFAULT 25)
    IS
    BEGIN
        UPDATE emp SET sal = sal + (sal *( v_porcentagem / 100 ) )
        where empno = v_codigo_emp;
    COMMIT;
    END reajuste;
END rh;
 
DECLARE
    v_sal NUMBER(8,2);
BEGIN
    v_sal := rh.descobrir_salario(1);
    DBMS_OUTPUT.PUT_LINE(v_sal);
END;
    
SELECT * FROM emp;

SELECT rh.descobrir_salario(1) FROM dual;

DECLARE
    v_sal NUMBER(8,2);
BEGIN
    v_sal := rh.descobrir_salario(1);
    DBMS_OUTPUT.PUT_LINE('Salario atual - ' || v_sal);
    rh.reajuste(1);
    v_sal := rh.descobrir_salario(1);
    DBMS_OUTPUT.PUT_LINE('Salario atualizado - ' || v_sal);
END;

------------------------------------------------------------
---------------------EXERCÍCIO 1----------------------------
-- CRIANDO O PROCESSO DE CÁLCULO DE MÉDIA USANDO PACKAGES --

CREATE TABLE alunos (
Aluno_numero NUMBER(3), 
nota1 NUMBER(2,1),
nota2 NUMBER(2,1),
media NUMBER(2,1)
);

INSERT INTO alunos VALUES (1, 5, 7);
INSERT INTO alunos VALUES (2, 4, 10);

CREATE OR REPLACE PACKAGE pacote_media 
as
    FUNCTION calcular_media(p_id IN alunos.Aluno_numero%TYPE)
        RETURN NUMBER
        IS
            v_media alunos.media%TYPE := 0;
        BEGIN
            SELECT sal INTO v_salario FROM emp WHERE empno = p_id;
            RETURN v_salario;
        END descobrir_salario;
    PROCEDURE reajuste(v_codigo_emp IN emp.empno%type,
                   v_porcentagem IN number DEFAULT 25)
    IS
    BEGIN
        UPDATE emp SET sal = sal + (sal *( v_porcentagem / 100 ) )
        where empno = v_codigo_emp;
    COMMIT;
    END reajuste;
END rh;




