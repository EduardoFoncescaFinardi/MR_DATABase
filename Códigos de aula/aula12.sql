Habilitando sa�da de dados no ambiente
set serveroutput on

Desabilitando repeti��o de c�digo nas mensagens
set verify off

-- coment�rio de linha
/* coment�rio v�rias linhas*/

begin
-- sa�da de dados
    dbms_output.put_line('OI');
end;

begin
-- sa�da de dados
    dbms_output.put_line('OI');
    dbms_output.put_line('OI novamente');
end;

usando variaveis de memoria

declare
    v_nome varchar(10) := 'Fiap';
begin
    dbms_output.put_line(v_nome);
-- pipe pipe || concatena msg est�tica com variavel de memoria    
    dbms_output.put_line('Mostrando conte�do: '||v_nome);
end;

declare
    v_nome varchar(10) := 'Fiap';
    v_nota number(2) := 10;
begin
    -- pipe pipe || concatena msg est�tica com variavel de memoria    
    dbms_output.put_line('Mostrando conte�do: '||v_nome||' - Nota: '||v_nota);
end;

entrada de dados via teclado

declare
--& abre uma caixa de msg para digita��o via teclado de dados
    v_nome varchar(10) := '&Nome';
    v_nota number(2) := &valor_nota;
begin
    -- pipe pipe || concatena msg est�tica com variavel de memoria    
    dbms_output.put_line('Mostrando conte�do: '||v_nome||' - Nota: '||v_nota);
end;

Processamento

begin
    dbms_output.put_line(10 + 10);
end;

declare
--& abre uma caixa de msg para digita��o via teclado de dados
    v_1 number(4,2) := &Valor1;
    v_2 v_1%type := &valor2;
    v_res v_1%type;
begin
    v_res := v_1 + v_2;
    -- pipe pipe || concatena msg est�tica com variavel de memoria    
    dbms_output.put_line('Soma de '||v_1||' com '||v_2||' = '||v_res);
end;

Aula 2 - 28/02/24

set serveroutput on
set verify off

declare
    sx char(1) := '&sexo';
begin
    if sx = 'F' or sx = 'f' then
        dbms_output. put_line('Feminino');
    elsif sx = 'M' or sx = 'm' then
        dbms_output. put_line('Masculino');
    else
        dbms_output. put_line('Outros');
    end if;
end;

declare
    sx char(1) := upper('&sexo');
begin
    if sx = 'F' then
        dbms_output. put_line('Feminino');
    elsif sx = 'M' then
        dbms_output. put_line('Masculino');
    else
        dbms_output. put_line('Outros');
    end if;
end;

1- Escreva	um programa para ler 2 valores (considere que n�o ser�o informados 
valores iguais) e escrever o maior deles.

declare
    n1 number(2) := &valor_1;
    n2 number(2) := &valor_2;
begin
    if n1 = n2 then
        dbms_output.put_line('Os valores n�o podem ser iguais');
    elsif n1 > n2 then
        dbms_output.put_line('N1 maior: '||n1);
    else
        dbms_output.put_line('N2 maior: '||n2);
    end if;
end;

2- Escreva	um programa para ler o ano de nascimento de uma	pessoa e escrever uma 
mensagem que diga se ela poder� ou n�o votar este ano	
(n�o � necess�rio considerar o m�s em que ela nasceu).

declare
    ano_nasc number(4) := &ano_nascimento;
    tempo number(4) := 2024 - ano_nasc;
begin
    if tempo >= 16 then
        dbms_output.put_line('Voto permitido');
    else
        dbms_output.put_line('Voto n�o permitido');
    end if;
end;

3- Escreva	um programa que verifique a validade de uma senha fornecida pelo usu�rio. 
A senha v�lida � o n�mero 1234.Devem ser impressas as seguintes mensagens:	
	ACESSO PERMITIDO caso a senha seja v�lida.	
	ACESSO NEGADO caso a senha seja	inv�lida.
    
declare
    
4- As ma��s custam R$ 0,30 cada se forem compradas menos do que uma d�zia, 
e R$0,25 se forem compradas pelo menos doze. Escreva um programa que leia o n�mero
de ma��s compradas, calcule e escreva o valor total da compra.

Aula 3 - 06/03/24

Exerc�cio - carga de dados

Exerc�cio:

Tabela: Notas
    rm_aluno - nm_disc - cp1 - cp2 - cp3 - media
    1        - PLSQL   - 10  - 7.5 - 7.5
    1        - POO     - 4.5 - 10  - 7.5
    1        - IA      - 7.5 - 6.5 - 10
    1        - JAVA    - 8   - 2.5 - 2.5

Criar a tabela, inserir dados
Criar um bloco pl para calcular a m�dia e atualizar seu valor na tabela

incluir as colunas: carga_hora - N - 3
                    num_falta - N - 3
                    situacao - A - 40

criar um bloco pl para incluis�o dos valores de acordo com a tabela
a seguir:

Tabela: Notas
    rm_aluno - nm_disc - cp1 - cp2 - cp3 - media - carga_hora - num_faltas - situacao
    1        - PLSQL   - 10  - 7.5 - 7.5         - 100        - 0
    1        - POO     - 4.5 - 10  - 7.5         - 100        - 90
    1        - IA      - 1.5 - 1.5 - 1.0         - 80         - 10
    1        - JAVA    - 8   - 2.5 - 2.5         - 80         - 70
    1        - IOT     - 5.0 - 5.0 - 5.0         - 80         - 20
    
Gravar a situa��o de acordo com as regras a seguir:

M�dia >= 6.0 e faltas < 25% da carga hor�ria, situa��o: Aprovado
M�dia >= 6.0 e faltas >= 25% da carga hor�ria, situa��o: Rep. por faltas
M�dia >= 4.5 e < 6.0 e faltas < 25% da carga hor�ria, situa��o: DP
M�dia < 4.5 e faltas < 25% da carga hor�ria, situa��o: Rep. por nota
M�dia < 4.5 e faltas >= 25% da carga hor�ria, situa��o: Rep. por nota e faltas

1- Criar a tabela Notas
    drop table notas1;
    create table notas1 (rm_aluno number(2), nm_disc varchar(20),
                        cp1 number(3,1), cp2 number(3,1), cp3 number(3,1), 
                        media number(3,1));
2- Criar um bloco PL para inser��o dos dados
    begin
        insert into notas1 values(1,'PLSQL',10,7.5,7.5, null);
        insert into notas1 values(1,'POO',4.5,10,7.5,null);
        insert into notas1 values(1,'IA',7.5,6.5,10,null);
        insert into notas1 values(1,'JAVA',8,2.5,2.5,null);
        commit;
    end;
 OU       
    begin
        insert into notas1 values(&RM1,'&Disciplina1',&CP1,&CP2,&CP3, null);
        insert into notas1 values(&RM1,'&Disciplina2',&CP1,&CP2,&CP3,null);
        insert into notas1 values(&RM1,'&Disciplina3',&CP1,&CP2,&CP3,null);
        insert into notas1 values(&RM1,'&Disciplina4',&CP1,&CP2,&CP3,null);
        commit;
    end;
        
select * from notas1;

Aula - 13/03/24 - CP1
Aula 4 - 20/03/24 - exerc�cios
Desenvolver um bloco de programa��o que efetue a soma de todos os 
n�meros �mpares que s�o m�ltiplos de 
tr�s e que se encontram no conjunto dos n�meros de 1 at� 500.

Desenvolver um bloco de programa��o que leia um valor inicial A e 
imprima a seq��ncia de valores do c�lculo de 
A! (fatorial) e o seu resultado. Ex: 5! = 5 X 4 X 3 X 2 X 1 = 120

Desenvolver um bloco de programa��o que leia 50 valores e encontre o maior
e o menor deles. Mostre o resultado.

Aula 4 - 27/03/24 - exerc�cios

Aula 5 - 03/04/24

Calend�rio

CP1 - 13/03
CP2 - 24/04
CP3 - 22/05
Sprint 1 - 15/04
Sprint 2 - 20/05
GS - 27/05 a 07/06
Sub - ????
Exame - ????

08/05/24

Exception - tratamento de erros - pr� definida

DECLARE
	...
BEGIN	
	...
	EXCEPTION
		WHEN NOME_DA_EXCE��O THEN
		RELA��O_DE_COMANDOS;
		WHEN NOME_DA_EXCE��O THEN
		RELA��O_DE_COMANDOS;
		...
END;

Exemplo
drop table aluno1 cascade constraints;
create table aluno1 (ra number(1) primary key, nome varchar(20));

insert into aluno1 values (1,'Marcel');
insert into aluno1 values (2,'Adriana');
insert into aluno1 values (3,'Samuel');
commit;

set serveroutput on
set verify off

DECLARE
	V_RA ALUNO1.RA%TYPE := &ra;
	V_NOME ALUNO1.NOME%TYPE := '&nome';
BEGIN
	insert into aluno1 values (v_ra, v_nome);
	DBMS_OUTPUT.PUT_LINE('Processo realizado com sucesso');
	EXCEPTION
      WHEN dup_val_on_index THEN
		DBMS_OUTPUT.PUT_LINE ('Ops, Ra j� cadastrado');
END;

select * from aluno1

DECLARE
	V_RA ALUNO1.RA%TYPE := &rm;
	V_NOME ALUNO1.NOME%TYPE;
BEGIN
	SELECT NOME INTO V_NOME FROM ALUNO1 WHERE RA > V_Ra;
	DBMS_OUTPUT.PUT_LINE(V_RA ||' - '|| V_NOME);
	EXCEPTION
      	/*WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE ('N�o h� nenhum aluno com este RM');
		WHEN TOO_MANY_ROWS THEN
			DBMS_OUTPUT.PUT_LINE ('H� mais de um aluno com este RA');*/
        WHEN others THEN
			DBMS_OUTPUT.PUT_LINE ('c vira loko'); 
END;

set serveroutput on
select * from aluno

Personalizada

DECLARE
	NOME_DA_EXCE��O EXCEPTION;
BEGIN
	...
	IF ... THEN
		RAISE NOME_DA_EXCE��O;
	END IF;
	...
	EXCEPTION
		WHEN NOME_DA_EXCE��O THEN
		RELA��O_DE_COMANDOS
END;

select * from aluno1
DECLARE
	V_CONTA NUMBER(2);
	TURMA_CHEIA EXCEPTION;
BEGIN
	SELECT COUNT(RA) INTO V_CONTA FROM ALUNO1;
	IF V_CONTA = 5 THEN 
		RAISE TURMA_CHEIA;
	ELSE 
		INSERT INTO ALUNO1 VALUES (&rm,'&nome');
	END IF;
    EXCEPTION
        WHEN TURMA_CHEIA THEN
		DBMS_OUTPUT.PUT_LINE('N�o foi poss�vel incluir: turma cheia');
END;

Exerc�cio: criar a tabela produto com os seguintes campos:
id_prod, nome_prod e dt_fab

drop table produto cascade constraints;
create table produto (id_prod number(3) primary key,
                      nome_prod varchar(20), dt_fab date);

drop table auditoria cascade constraints;
create table auditoria (err_cod varchar(10), err_msg varchar(200), 
                        err_dt date);
                        
criar um bloco pl para inserir dados nesta tabela, n�o esque�a de usar a exception
caso um produto com c�digo j� cadastrado seja usado novamente.

declare
    v_id_prod number(3) := &id_prod;
    v_nome_prod varchar(20) := '&nome_prod';
    v_dt_fab date := '&dt_fab';
begin
    insert into produto values (v_id_prod, v_nome_prod, v_dt_fab);
    commit;
exception
    when dup_val_on_index then
        dbms_output.put_line('C�digo j� cadastrado');
end;

select * from produto

declare
    v_id_prod number(3) := &id_prod;
    v_nome_prod varchar(20) := '&nome_prod';
    v_dt_fab date := '&dt_fab';
    err_code varchar(10);
    err_msg varchar(200);
begin
    insert into produto values (v_id_prod, v_nome_prod, v_dt_fab);
    commit;
EXCEPTION
   WHEN OTHERS THEN
      err_code := SQLCODE; --redebe o c�digo do erro
      err_msg := SUBSTR(SQLERRM, 1, 100); -- recebe a msg de erro
      INSERT INTO auditoria (err_cod, err_msg, err_dt)
    VALUES (err_code, err_msg, sysdate);
END;

delete from auditoria

select * from auditoria

criar um bloco pl para buscar na tabela produto atrav�s do c�digo do mesmo seus dados,
caso o produto n�o exista crie uma exception para previnir este problema de sa�da de
dados.

DECLARE
	V_id   produto.id_prod%TYPE := &id_prod;
	V_NOME produto.nome_prod%TYPE;
    v_dt   produto.dt_fab%type;
BEGIN
	SELECT id_prod, nome_prod, dt_fab INTO V_id, v_nome, v_dt
    FROM produto WHERE id_prod = V_id;
	DBMS_OUTPUT.PUT_LINE(v_id||' - '|| V_NOME||' - '||v_dt);
	EXCEPTION
    	WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE ('N�o h� nenhum produto com este c�digo');
END;

Fun��es

CREATE OR REPLACE FUNCTION nome_fun��o (p1 in/out ou in/out, p2...)
RETURN tipo_dados
IS
    variaveis locais
BEGIN
    programa��o    
 RETURN nome_fun��o;
END;

IN (padr�o): Passa um valor do ambiente chamador para function/procedure
e este valor n�o pode ser alterado dentro dela (passagem de par�metro
por valor).

OUT: Passa um valor da function/procedure para o ambiente chamador
(passagem de par�metro por refer�ncia).

IN OUT: Passa um valor do ambiente chamador para a function/procedure.
Esse valor pode ser alterado dentro da function/procedure e retornar 
com o valor atualizado para o ambiente chamador (passagem de par�metro
por refer�ncia).

Chamada, passagem de par�metros, sa�da de dados

SELECT nome_fun��o(valor1,valorn) FROM dual;

Exemplo:
drop table funcionarios_tbl cascade constraints;
create table funcionarios_tbl
(primeiro_nome varchar(30),
 id number(2));
 
 insert into funcionarios_tbl values ('Marcel', 10);
 insert into funcionarios_tbl values ('Andrea', 20);
 insert into funcionarios_tbl values ('Samuel', 90);
 commit;

CREATE OR REPLACE FUNCTION primeiro_nome_func
RETURN VARCHAR
IS
  emp_name VARCHAR(20);
BEGIN
    SELECT primeiro_nome INTO emp_name  FROM funcionarios_tbl 
    WHERE ID = 90;
    RETURN emp_name;
END;

SELECT primeiro_nome_func FROM dual;
select * from funcionarios_tbl;

create or replace function teste_soma (p1 in number, p2 in number)
return number
is
soma number(4);
begin
    soma := p1 + p2;
    return soma;
end;

select teste_soma(10,15) from dual;

set serveroutput on
declare
    n1 number(4) := &valor1;
    -- usando a heran�a com%type - tipo + tamanho
    -- usando entrada de dados via teclado &
    n2 n1%type   := &valor2;
    re n1%type;
begin
    --chamando a fun��o via variavel de memoria
    re := teste_soma(n1, n2);
    dbms_output.put_line(re);
end;

Criar uma fun��o que analise dois valores num�ricos inteiros e retorne o maior deles.


Aula 14/08/2024

Procedimentos

set serveroutput on
set verify off

CREATE OR REPLACE PROCEDURE nome_procedure
(argumento1 IN | OUT |IN OUT tipo_de_dados,
argumento2 IN | OUT |IN OUT tipo_de_dados,
...
argumentoN IN | OUT |IN OUT tipo_de_dados) IS | AS
vari�veis locais, constantes, ...
BEGIN
...
END nome_procedure;

IN (padr�o): Passa um valor do ambiente chamador para procedure e este
valor n�o pode ser alterado dentro dela (passagem de par�metro por valor).
OUT: Passa um valor da procedure para o ambiente chamador (passagem de
par�metro por refer�ncia).
IN OUT: Passa um valor do ambiente chamador para a procedure. Esse valor
pode ser alterado dentro da procedure e retornar com o valor atualizado para
o ambiente chamador (passagem de par�metro por refer�ncia).
Nota: As palavras-chave IS ou AS (ap�s a declara��o dos par�metros) podem ser
utilizadas, pois nesse contexto s�o equivalentes.

Exemplo:

drop table aluno cascade constraints;
create table aluno ( ra char(2) primary key,
                     nome varchar(20));
insert into aluno values('1','Marcel');
insert into aluno values('2','Silmara');
commit;
CREATE OR REPLACE PROCEDURE PROC_NOME_ALUNO (P_RA IN CHAR) 
IS
V_NOME VARCHAR2(50);
BEGIN
SELECT NOME INTO V_NOME FROM ALUNO WHERE RA = P_RA;
DBMS_OUTPUT.PUT_LINE (V_NOME);
END PROC_NOME_ALUNO;

Chamada, execu��o:
EXEC PROC_NOME_ALUNO(1);

Agora desenvolva o seu projeto da aula passada



