------aula10 - 23/04/2024-------
set serveroutput on
----exercício 1---
----Criar um bloco PL/SQL (usando cursor) para atualizar a tabela abaixo, conforme segue:
----Produtos cateogria A deverão ser reajustados em 5%
----Produtos categoria B deverão ser reajustados em 10%
----Pordutos categoria C deverão ser reajustados em 15%
----
CREATE TABLE PRODUTO_Cp(
    CODIGO NUMBER(4),
    CATEGORIA CHAR(1),
    VALOR NUMBER(4,2)
);

INSERT INTO PRODUTO_Cp VALUES (1001,'A',7.55);
INSERT INTO PRODUTO_Cp VALUES (1002,'B',5.95);
INSERT INTO PRODUTO_Cp VALUES (1003,'C',3.45);

-----------------------------------------------------------------------
DECLARE
    v_codigo PRODUTO_Cp.CODIGO%TYPE;
    v_categoria PRODUTO_Cp.CATEGORIA%TYPE;
    v_valor PRODUTO_Cp.VALOR%TYPE;
    
    CURSOR c_produtos IS
        SELECT CODIGO, CATEGORIA, VALOR
        FROM PRODUTO_Cp;
BEGIN
    FOR produto IN c_produtos LOOP
        v_codigo := produto.CODIGO;
        v_categoria := produto.CATEGORIA;
        v_valor := produto.VALOR;
        
        IF v_categoria = 'A' THEN
            v_valor := v_valor * 1.05; 
        ELSIF v_categoria = 'B' THEN
            v_valor := v_valor * 1.10; 
        ELSIF v_categoria = 'C' THEN
            v_valor := v_valor * 1.15; 
        END IF;
        
        
        UPDATE PRODUTO_Cp
        SET VALOR = v_valor
        WHERE CODIGO = v_codigo;
        
       
        DBMS_OUTPUT.PUT_LINE('Produto ' || v_codigo || ' atualizado para R$ ' || v_valor);
    END LOOP;
    
    COMMIT; 
END;
-----------------------------------------------------------------------
DECLARE
    CURSOR C_reajuste IS SELECT * FROM produto_cp;
BEGIN
    FOR V_reajuste IN C_reajuste LOOP
    if v_reajuste.categoria = 'A' then
        dbms_output.put_line('5%->'||V_reajuste.valor*1.05);
        update produto_cp set valor = v_reajuste.valor *1.05
        where codigo = v_reajuste.codigo;
    elsif v_reajuste.categoria = 'B' then
        dbms_output.put_line('10%->' || v_reajuste.valor*1.1);
        update produto_cp set valor = v_reajuste.valor *1.1
        where codigo = v_reajuste.codigo;
    else
        dbms_output.put_line('15%->' || v_reajuste.valor*1.15);
        update produto_cp set valor = v_reajuste.valor *1.15
        where codigo = v_reajuste.codigo;  
    end if;
END LOOP;
END;

--exercício 2
--Criar um bloco que receberá um RA, um NOME e quatro notas confirme a sequência: (RA,NOME,A1,A2,A3,A4), mínimo de dados: 2 linhas uma
--aprovado e uma para reprovado.
--A partir cirar um bloco usando cursores para processar o cálculo da média somando o maior valor entre A1 e A2 ás notas A3 e A4 dividindo
--o valor obtido por três(achando a média).
--Se a média for menor que 6 (seis) o aluno estará REPROVADO e se a média for igual ou superior a 6 (seis) o aluno  estará APROVADO.
--O bloco deverá inserir os valroes acima numa tabela denominada ALUNO com as seguintes colunas RA,NOME,A1,A2,A3,A4,MEDIA,RESULTADO.

CREATE TABLE aluno_cp (
    ra number(2) primary key,
    nome varchar(20),
    A1 number(4,2), 
    A2 number(4,2),
    A3 number(4,2), 
    A4 number(4,2),
    media number(4,2),
    resultado varchar(15)
);
----------------------------------------------------

DECLARE
    CURSOR C_med_situa IS SELECT * FROM aluno_cp;
    maior number(4,2);
    v_media number(4,2);
BEGIN
    FOR V_med_situa IN C_med_situa LOOP
    if v_med_situa.a1> v_med_situa.a2 then
        maior := v_med_situa.a1;
        dbms_output.put_line('Maior->'||maior);
    else
        maior := v_med_situa.a2;
        dbms_output.put_line('Maior->'|| maior);
    end if;
    v_media := (

        
