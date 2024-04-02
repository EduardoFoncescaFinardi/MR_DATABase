set serveroutput on

DECLARE 
    V_CONTADOR NUMBER(2):= 1;
    
BEGIN 

LOOP
    DBMS_OUTPUT.PUT_LINE(V_CONTADOR);
    V_CONTADOR := V_CONTADOR + 1;
    EXIT WHEN V_CONTADOR > 20;
END LOOP;
END;

DECLARE 
    V_CONTADOR NUMBER(2):= 1;
    
BEGIN 

WHILE V_CONTADOR <= 20 LOOP
    DBMS_OUTPUT.PUT_LINE(V_CONTADOR);
    V_CONTADOR := V_CONTADOR +1;

END LOOP;
END;

BEGIN
FOR V_CONTADOR IN 1..20 LOOP
DBMS_OUTPUT.PUT_LINE(V_CONTADOR);
END LOOP;
END;


BEGIN
FOR V_CONTADOR IN REVERSE 1..20 LOOP
DBMS_OUTPUT.PUT_LINE(V_CONTADOR);
END LOOP;
END;

--exercício 1
-- MOSTRAR UM BLOCO DE PROGRAMAÇÃO QUE REALIZE O PROCESSAMENTO DE UMA TABUADA QUALQUER, POR EXEMPLO A TABUADA DO NÚMERO 150.

DECLARE 
    V_TABUADA NUMBER(2) := &TABUADA;
    V_CONTADOR NUMBER(2) := 0;

BEGIN
LOOP
    DBMS_OUTPUT.PUT_LINE(V_CONTADOR || 'X' || V_TABUADA || '=' || V_CONTADOR * V_TABUADA);
    V_CONTADOR := V_CONTADOR + 1;
    EXIT WHEN V_CONTADOR > 10;
END LOOP;
END;

--exercício 2
-- Em um intervalo numérico inteiro, informar quantos números são pares e quantos são ímpares.

DECLARE
    v_intervalo number(2) := &intervalo;
    v_contador number(2) := 0;
    contpar number(2) := 0;
    contimpar number(2) := 0;
BEGIN
WHILE v_contador != v_intervalo LOOP
    V_CONTADOR := V_CONTADOR + 1;
    IF MOD(v_contador,2) = 0 THEN
        DBMS_OUTPUT.PUT_LINE(v_contador || ' É PAR!');
        contpar := contpar + 1;
    ELSE
        DBMS_OUTPUT.PUT_LINE(v_contador || ' É IMPAR!');
        contimpar := contimpar +1;
    END IF;
END LOOP;
DBMS_OUTPUT.PUT_LINE('Contagem par: ' || contpar);
DBMS_OUTPUT.PUT_LINE('Contagem impar: ' || contimpar);
END;

-- exercício 3
-- Exibir a média dos valores pares em um intervalo numérico e soma dos ímpares.

DECLARE
    acpar number(3):= 0;
    acimpar number(3):= 0;
    contpar number(3):= 0;
    contimpar number(3):= 0;


BEGIN
    for v_conta in 1..10 loop
        if mod(v_conta, 2) = 0 then
            acpar := acpar +v_conta;
            contpar := contpar +1;
        else
            acimpar := acimpar + v_conta;
            contimpar := contimpar + 1;
        end if;
    end loop;
DBMS_OUTPUT.PUT_LINE('Contagem par: ' || contpar);
DBMS_OUTPUT.PUT_LINE('Contagem impar: ' || contimpar);
DBMS_OUTPUT.PUT_LINE('Média pares: ' || acpar/contimpar);
DBMS_OUTPUT.PUT_LINE('Soma impares: ' || acimpar);
end;



