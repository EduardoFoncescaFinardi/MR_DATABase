----------AULA 2/04----------------------------------
----------COME?ANDO ESTRUTURA DE REPETI??O-----------

set serveroutput on
SET VERIFY OFF

------------------LOOP/EXIT WHEN----------------------
DECLARE

    V_CONTADOR NUMBER(20):= 1;

BEGIN

LOOP

    dbms_output.put_line(V_CONTADOR);
    V_CONTADOR:= V_CONTADOR + 1;
    EXIT WHEN V_CONTADOR > 20;
END LOOP;

END;


----------------------------------------------
-------------------WHILE----------------------

DECLARE

    V_CONTADOR NUMBER(20):= 1;

BEGIN

WHILE V_CONTADOR <= 20 LOOP
    dbms_output.put_line(V_CONTADOR);
    V_CONTADOR:= V_CONTADOR + 1;
END LOOP;

END;



----------------------------------------------
-------------------FOR----------------------

BEGIN

FOR V_CONTADOR IN 1..20 LOOP
    dbms_output.put_line(V_CONTADOR);
END LOOP;

END;


-------------------FOR/REVERSE- CONTA DE TRAS PRA FRENTE----------------------

BEGIN

FOR V_CONTADOR IN REVERSE 1..20 LOOP
    dbms_output.put_line(V_CONTADOR);
END LOOP;

END;



-------------------EXERCICIOS LA?OS DE REPETI??O------------------------------
------EXERCICIO 1------

------WHILE------
DECLARE

    V_CONTADOR NUMBER(20):= 1;
    

BEGIN

WHILE V_CONTADOR <= 10 LOOP
    dbms_output.put_line('150 ' || 'X ' || V_CONTADOR || ' = ' || 150 * V_CONTADOR);
    V_CONTADOR:= V_CONTADOR + 1;
END LOOP;

END;


------FOR------

BEGIN

FOR V_CONTADOR IN 1..10 LOOP
    dbms_output.put_line('150 ' || 'X ' || V_CONTADOR || ' = ' || 150 * V_CONTADOR);
END LOOP;

END;


------EXERCICIO 2------

DECLARE

 V_NUMERO_PAR NUMBER(20):= 0;
 V_NUMERO_IMPAR NUMBER(20):= 0;
 V_CONTADOR NUMBER(20):= 1;



BEGIN

WHILE V_CONTADOR <= 10 LOOP

    IF MOD(V_CONTADOR,2) = 0 THEN --o mod faz divisao e analisa o resto
    V_NUMERO_PAR:= V_NUMERO_PAR + 1;
    else
        V_NUMERO_IMPAR:= V_NUMERO_IMPAR + 1;
    end if;

V_CONTADOR:= V_CONTADOR + 1;
END LOOP;

dbms_output.put_line('PARES:' || V_NUMERO_PAR || '  IMPARES:' || V_NUMERO_IMPAR);

END;




------EXERCICIO 3------


DECLARE

 SOMA_PAR NUMBER(5):=0;
 SOMA_IMPAR NUMBER(5):=0;
 V_NUMERO_PAR NUMBER(20):= 0;
 V_NUMERO_IMPAR NUMBER(20):= 0;
 V_CONTADOR NUMBER(20):= 1;



BEGIN

WHILE V_CONTADOR <= 10 LOOP

    IF MOD(V_CONTADOR,2) = 0 THEN --o mod faz divisao e analisa o resto
    V_NUMERO_PAR:= V_NUMERO_PAR + 1;
    SOMA_PAR:= SOMA_PAR + V_CONTADOR;
    else
        SOMA_IMPAR:= SOMA_IMPAR + V_CONTADOR;
    end if;

V_CONTADOR:= V_CONTADOR + 1;
END LOOP;

dbms_output.put_line('M?DIA PARES:' || SOMA_PAR / V_NUMERO_PAR);
dbms_output.put_line('SOMA IMPARES:' || SOMA_IMPAR);


END;


------EXERCICIO 4------
--Desenvolver um bloco de programa??o que efetue a soma de todos os n?meros ?mpares que s?o m?ltiplos de  tr?s e que se encontram no conjunto dos n?meros de 1 at? 500.



DECLARE

 SOMA_IMPAR NUMBER(5):=0;
 V_NUMERO_IMPAR NUMBER(20):= 0;
 V_CONTADOR NUMBER(20):= 1;



BEGIN

WHILE V_CONTADOR <= 500 LOOP

    IF MOD(V_CONTADOR,2) = 1 THEN --o mod faz divisao e analisa o resto
        IF MOD(V_CONTADOR,3) = 0 THEN
            SOMA_IMPAR:= SOMA_IMPAR + V_CONTADOR;
        end if;
    end if;

V_CONTADOR:= V_CONTADOR + 1;
END LOOP;

dbms_output.put_line('SOMA DE IMPARES MULTIPLOS DE 3 AT? O 500: ' || SOMA_IMPAR );


END;


------EXERCICIO 5------
--Desenvolver um bloco de programa??o que leia um valor inicial A e imprima a seq??ncia de valores do c?lculo de  A! (fatorial) e o seu resultado. Ex: 5! = 5 X 4 X 3 X 2 X 1 = 120


DECLARE

v_numero number(10):= &valor;


BEGIN

FOR V_CONTADOR IN REVERSE 1..v_numero-1 LOOP
    v_numero:= v_numero * V_CONTADOR;
    END LOOP;
dbms_output.put_line(v_numero);

END;


------EXERCICIO 6------
--Desenvolver um bloco de programa??o que leia 50 valores e encontre o maior e o menor deles. Mostre o resultado



























-------------------AULA 09/04 CURSORES ----------------
--SELECT SYSDATE FROM DUAL;

CREATE TABLE FUNCIONARIO(

CD_FUN NUMBER(5),
NM_FUN VARCHAR2 (50),
SALARIO NUMBER(10),
DT_ADM DATE,
CONSTRAINT CD_FUN_PK PRIMARY KEY (CD_FUN)
);

--09-APR-24
BEGIN

INSERT INTO FUNCIONARIO (CD_FUN, NM_FUN, SALARIO, DT_ADM) VALUES (1, 'Marcel', 10000, '17-APR-20');
INSERT INTO FUNCIONARIO (CD_FUN, NM_FUN, SALARIO, DT_ADM) VALUES (2, 'Claudia', 16000, '02-OCT-98');
INSERT INTO FUNCIONARIO (CD_FUN, NM_FUN, SALARIO, DT_ADM) VALUES (3, 'Joaquim', 5500, '10-JUL-10');
INSERT INTO FUNCIONARIO (CD_FUN, NM_FUN, SALARIO, DT_ADM) VALUES (4, 'Valeria', 7300, '08-JUN-15');

COMMIT;

END;



-----------COM LOOP
DECLARE

CURSOR C_EXIBE IS SELECT NM_FUN, SALARIO FROM FUNCIONARIO;
V_EXIBE C_EXIBE%ROWTYPE;

BEGIN

    OPEN C_EXIBE;

    LOOP

        FETCH C_EXIBE INTO V_EXIBE;

    EXIT WHEN C_EXIBE%NOTFOUND;

    DBMS_OUTPUT.PUT_LINE('NOME:' || V_EXIBE.NM_FUN || '-SALÁRIO:' || V_EXIBE.SALARIO);

    END LOOP;

    CLOSE C_EXIBE;

END;

--------COM FOR

DECLARE 

    CURSOR C_EXIBE IS SELECT NM_FUN, SALARIO FROM FUNCIONARIO;
    
BEGIN

    FOR V_EXIBE IN C_EXIBE LOOP

    END LOOP;
    END;



--------------------------------------------------------

ALTER TABLE FUNCIONARIO
ADD TEMPO NUMBER(10);
--------------------------------------------------------


DECLARE 

    CURSOR C_EXIBE IS SELECT * FROM FUNCIONARIO;
    
BEGIN

    FOR V_EXIBE IN C_EXIBE LOOP
        UPDATE FUNCIONARIO SET TEMPO = SYSDATE - DT_ADM WHERE CD_FUN = V_EXIBE.CD_FUN;    
    END LOOP;
    
END;






---------------------------------------------------------

DECLARE 

    CURSOR C_EXIBE IS SELECT * FROM FUNCIONARIO;
    
BEGIN

    FOR V_EXIBE IN C_EXIBE LOOP
    
    IF V_EXIBE.TEMPO > 4500 THEN
        UPDATE FUNCIONARIO SET SALARIO = (0.1 * SALARIO) + SALARIO WHERE CD_FUN = V_EXIBE.CD_FUN;
    ELSE
        UPDATE FUNCIONARIO SET SALARIO = (0.05 * SALARIO) + SALARIO WHERE CD_FUN = V_EXIBE.CD_FUN;

    END IF;
    END LOOP;
    
END;











