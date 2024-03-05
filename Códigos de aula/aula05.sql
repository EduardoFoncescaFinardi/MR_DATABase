set serveroutput on;
SET VERIFY OFF;

Exercícios 
-- 1 - Escreva um programa para ler 2 valores (considere que não serão informados
-- valores iguais) e escrever o maior deles.

DECLARE

    V_num1 float(10) := &valor1;
    v_num2 float(10) := &valor2;
    
BEGIN

    if v_num1 > v_num2 then
        DBMS_OUTPUT.PUT_LINE( v_num1 ||' é maior que ' || v_num2 || ', portanto n1 > n2');
    elsif v_num2 > v_num1 then
        DBMS_OUTPUT.PUT_LINE( v_num2 ||' é maior que ' || v_num1 || ', portanto n2 > n1');
    else
        DBMS_OUTPUT.PUT_LINE('Os número são iguais');
    end if;
    
end;

-- 2- Escreva um programa para ler o ano de nascimento de uma pessoa e escrever
-- uma mensagem que diga se ela poderá ou não votar este ano
-- (não é necessário considerar o mês em que ela nasceu).

DECLARE 

    anonascimento int(4) := &anonascimento;   
    calculo_da_idade int(2);
    
BEGIN

    calculo_da_idade := 2024 - anonascimento; 
    if calculo_da_idade >= 16 then
        DBMS_OUTPUT.PUT_LINE('Pode Votar');
    else 
        DBMS_OUTPUT.PUT_LINE('Não pode Votar');

    end if;
    
end;
    
        
3- Escreva um programa que verifique a validade de uma senha fornecida
pelo usuário.  A senha válida é o número 1234. Devem ser impressas as 
seguintes mensagens: ACESSO PERMITIDO caso a senha seja válida.
ACESSO NEGADO caso a senha seja inválida.

declare

    senha int(4) := &senha;

begin
    
    if senha = 1234 then
        DBMS_OUTPUT.PUT_LINE('ACESSO PERMITIDO');
    else
        DBMS_OUTPUT.PUT_LINE('ACESSO NEGADO');
    end if;

end;
   


4- As maçãs custam R$ 0,30 cada se forem compradas menos do que uma dúzia,
e R$0,25 se forem compradas pelo menos doze. Escreva um programa que leia o
número de maçãs compradas, calcule e escreva o valor total da compra.

declare

    v_qnt_maças int := &v_qnt_maças;
    calculo float;
    
begin 
    
    if v_qnt_maças >= 12 then
        calculo := v_qnt_maças*(0.25);
        DBMS_OUTPUT.PUT_LINE('valor total da compra: '|| calculo);
    else 
        calculo := v_qnt_maças*(0.3);
        DBMS_OUTPUT.PUT_LINE('valor total da compra: '|| calculo);
    end if;

end;

5- Criar a tabela: Notas_faltas e inserir (via plsql) as linhas de dados
rm_alu - nm_disc - cp1 - cp2 - cp3 - media
1      - PLSQL   - 10  - 8.5 - 9 
1      - IA      - 7.5 - 4.5 - 7
1      - JAVA    - 4.5 - 4.5 - 4.5
1      - IOT     - 10  - 10 - 10
Criar um bloco plsql para calcular a média de cada discilina
(uma por vez, ainda não sabemos usar cursores) e gravar na tabela notas
esta média.

CREATE TABLE BOLETIM(
    RM_ALUNO char(1),
    NM_DISC VARCHAR(50),
    NOTA_1 NUMBER(3,1),
    NOTA_2 NUMBER(3,1),
    NOTA_3 NUMBER(3,1),
    MEDIA NUMBER(3,1)
);

BEGIN
    INSERT INTO BOLETIM VALUES (1, 'PLSQL', 10, 7.5, 7.5, NULL);
    INSERT INTO BOLETIM VALUES (1, 'POO', 4.5, 10.0, 7.5, NULL);
    INSERT INTO BOLETIM VALUES (1, 'IA', 7.5, 6.5, 10.0, NULL);
    INSERT INTO BOLETIM VALUES (1, 'JAVA', 8.0, 2.5, 2.5, NULL);
end;
-- OU

BEGIN
    INSERT INTO BOLETIM VALUES (&RM, '&Disciplina1', &NOTA_1, &NOTA_2, &NOTA_3, NULL);
    INSERT INTO BOLETIM VALUES (&RM, '&Disciplina2', &NOTA_1, &NOTA_2, &NOTA_3, NULL);
    INSERT INTO BOLETIM VALUES (&RM, '&Disciplina3', &NOTA_1, &NOTA_2, &NOTA_3, NULL);
    INSERT INTO BOLETIM VALUES (&RM, '&Disciplina4', &NOTA_1, &NOTA_2, &NOTA_3, NULL);
END;

SELECT * FROM BOLETIM;

DECLARE 
    V_DISCIPLINA VARCHAR(20) := '&NOME_DISCIPLINA';
    V_CP1 NUMBER(3,1);
    V_CP2 V_CP1%TYPE;
    V_CP3 V_CP1%TYPE;
    V_MEDIA V_CP1%TYPE;
BEGIN
    SELECT NOTA_1,NOTA_2, NOTA_3 INTO V_CP1,V_CP2, V_CP3
        FROM BOLETIM WHERE NM_DISC = V_DISCIPLINA;
        V_MEDIA := (V_CP1 + V_CP2 + V_CP3) / 3;
    DBMS_OUTPUT.PUT_LINE(V_DISCIPLINA || ' - ' || v_cp1 || ' - ' || V_CP2 || ' - ' || V_CP3 || ' - ' || V_MEDIA);
    UPDATE BOLETIM SET MEDIA = V_MEDIA WHERE NM_DISC = V_DISCIPLINA;
END;
