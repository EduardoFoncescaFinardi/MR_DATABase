--aula 1 data: 06/02/2024--

SET SERVEROUTPUT ON 
-- ativando a saída de dados em tela
-- ativar sempre que começar um código SQL, facilita visualização

BEGIN
--exibindo dados em tela
DBMS_OUTPUT.PUT_LINE('FIAP');
--finalizando
END;

--declaração de variável de memória
DECLARE 
    NOME VARCHAR(20) := 'FIAP';
BEGIN
    DBMS_OUTPUT.PUT_LINE(nome);
END;

DECLARE 
    NOME VARCHAR(20) := 'FIAP';
BEGIN
--concatenando texto com variáveis de memória (precisa utilizar o pipe para...
--...juntar variáveis de memória com texto
    DBMS_OUTPUT.PUT_LINE('Faculdade ' ||nome);
END;

DECLARE 
    NOME VARCHAR(20) := 'FIAP';
    UNIDADE NOME%TYPE := 'Aclimação';
BEGIN
--concatenando texto com variáveis de memória 2
    DBMS_OUTPUT.PUT_LINE('Faculdade ' ||nome|| ' - Unidade ' ||unidade);
END;

--Processamento

DECLARE
    N1 NUMBER(2) := 10;
    N2 NUMBER(2) := 2;
BEGIN
    DBMS_OUTPUT.PUT_LINE(n1 + n2);
END;

DECLARE
    N1 NUMBER(2) := 10;
    N2 NUMBER(2) := 2;
    RESULTADO NUMBER(3) := N1 + N2;
BEGIN
    DBMS_OUTPUT.PUT_LINE('A soma de '||n1||' com '||n2||' é = '||resultado);
END;

DECLARE
--case o &valor1 seja um varchar e não Number, coloque o '&valor1' entre aspas
    N1 NUMBER(2) := &valor1;
    N2 NUMBER(2) := &valor2;
    RESULTADO NUMBER(3) := N1 + N2;
BEGIN
    DBMS_OUTPUT.PUT_LINE('A soma de '||n1||' com '||n2||' é = '||resultado);
END;

--Operadores aritméticos + - * / ()

--EXERCÍCIO 1--

DECLARE
    Salario number(4) := &valor1;
    resultado number(4) := Salario * 1.25;
Begin
    DBMS_OUTPUT.PUT_LINE(resultado);
end;

--EXERCÍCIO 2-- 

DECLARE
    valor_reais float(3) := 45;
    resultado float(3) := valor_reais * 5;
BEGIN
    DBMS_OUTPUT.PUT_LINE(resultado);
END;

--EXERCÍCIO 3--

DECLARE
    valor_dolares float(3) := &valor1;
    resultado float(3) := valor_dolares * 5;
BEGIN
    DBMS_OUTPUT.PUT_LINE(resultado);
END;
    




