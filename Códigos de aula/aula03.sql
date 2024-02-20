//aula 03 - 20/02/2024

//ativando servidor de exibiçã de dados


set serveroutput on
set verify off

DECLARE 
    V_N NUMBER(2) := &valor;

BEGIN 
//MOD = Resto da divisão
// := é atribuição de valor, se quiser jogar um valor a uma variável você deve usar esse símbolo

    IF MOD(V_N,2) = 0 THEN
        DBMS_OUTPUT.PUT_LINE('O NÚMERO ' || V_N || ' É PAR');
    ELSE 
        DBMS_OUTPUT.PUT_LINE('O NÚMERO ' || V_N || ' É IMPAR');
    END IF;
END;

//Operadores lógicos: and or not
//operadores aritiméticos + - * / ()
//operadores relacionais > >= < <= = <> ou !=



DECLARE 
    V_SEXO CHAR(1) := '&sexo'; 
    
BEGIN
    IF V_SEXO = 'm' or V_SEXO = 'M' THEN
        DBMS_OUTPUT.PUT_LINE('Sexo Masculino');
    ELSIF V_SEXO = 'f' or V_SEXO = 'F' THEN
        DBMS_OUTPUT.PUT_LINE('Sexo Feminino');
    ElSE
        DBMS_OUTPUT.PUT_LINE('Sexo inexistente');
    END IF;

END;

DECLARE 
--10,2 = 10 díitos, sendo o número 2 sendo a qnt de decimais. Ou seja nesse caso-
--são 8 dígitos inteiro e 2 decimais
    v_carro number(10,2) := &valor_carro;
    v_presta number(2):= &valor_prestação;

BEGIN
    IF v_presta = 6 Then
        v_presta := (v_carro * 1.1) / 6;
        DBMS_OUTPUT.PUT_LINE('Valor da prestação em 6x: ' ||v_presta);
    ELSIF v_presta = 12 Then
        v_presta := (v_carro * 1.15) / 12;
        DBMS_OUTPUT.PUT_LINE('Valor da prestação em 12x: ' ||v_presta);
    ELSIF v_presta = 16 Then    
        v_presta := (v_carro * 1.15) / 18;
        DBMS_OUTPUT.PUT_LINE('Valor da prestação em 18x: ' ||v_presta);    
    ELSE
        DBMS_OUTPUT.PUT_LINE('Valor da prestação inválido');    
    END IF;
END;

