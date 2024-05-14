Exception - tratamento de erros - pré definida

DECLARE
	...
BEGIN	
	...
	EXCEPTION
		WHEN NOME_DA_EXCEÇÃO THEN
		RELAÇÃO_DE_COMANDOS;
		WHEN NOME_DA_EXCEÇÃO THEN
		RELAÇÃO_DE_COMANDOS;
		...
END;

Exemplo
drop table aluno1 cascade constraints;
create table aluno1 (ra number(1) primary key, nome varchar(20));

insert into aluno1 values (1,'Marcel');
insert into aluno values (2,'Adriana');
insert into aluno values (3,'Samuel');
commit;

DECLARE
	V_RA ALUNO.RA%TYPE := 4;
	V_NOME ALUNO.NOME%TYPE;
BEGIN
	SELECT NOME INTO V_NOME FROM ALUNO WHERE RA = V_RA;
	DBMS_OUTPUT.PUT_LINE(V_RA ||' - '|| V_NOME);
	EXCEPTION
    	WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE ('Não há nenhum aluno com este RA');
		WHEN TOO_MANY_ROWS THEN
			DBMS_OUTPUT.PUT_LINE ('Há mais de um aluno com este RA');
        WHEN others THEN
			DBMS_OUTPUT.PUT_LINE ('c vira loko');
END;
set serveroutput on
select * from aluno

Personalizada

DECLARE
	NOME_DA_EXCEÇÃO EXCEPTION;
BEGIN
	...
	IF ... THEN
		RAISE NOME_DA_EXCEÇÃO;
	END IF;
	...
	EXCEPTION
		WHEN NOME_DA_EXCEÇÃO THEN
		RELAÇÃO_DE_COMANDOS
END;

select * from aluno
DECLARE
	V_CONTA NUMBER(2);
	TURMA_CHEIA EXCEPTION;
BEGIN
	SELECT COUNT(RA) INTO V_CONTA FROM ALUNO;
	IF V_CONTA = 5 THEN 
		RAISE TURMA_CHEIA;
	ELSE 
		INSERT INTO ALUNO VALUES (4,'Rafaela');
	END IF;
    EXCEPTION
        WHEN TURMA_CHEIA THEN
		DBMS_OUTPUT.PUT_LINE('Não foi possível incluir: turma cheia');
END;

Exercício: criar a tabela produto com os seguintes campos:
id_prod, nome_prod e dt_fab

drop table produto cascade constraints;
create table produto (id_prod number(3) primary key,
                      nome_prod varchar(20), dt_fab date);

drop table auditoria cascade constraints;
create table auditoria (err_cod varchar(10), err_msg varchar(200), 
                        err_dt date);
                        
criar um bloco pl para inserir dados nesta tabela, não esqueça de usar a exception
caso um produto com código já cadastrado seja usado novamente.

declare
    v_id_prod number(3) := &id_prod;
    v_nome_prod varchar(20) := '&nome_prod';
    v_dt_fab date := '&dt_fab';
begin
    insert into produto values (v_id_prod, v_nome_prod, v_dt_fab);
    commit;
exception
    when dup_val_on_index then
        dbms_output.put_line('Código já cadastrado');
end;

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
      err_code := SQLCODE;
      err_msg := SUBSTR(SQLERRM, 1, 100);
      INSERT INTO auditoria (err_cod, err_msg, err_dt)
    VALUES (err_code, err_msg, sysdate);
END;

delete from auditoria

select * from auditoria;   
select * from produto;

criar um bloco pl para buscar na tabela produto através do código do mesmo seus dados,
caso o produto não exista crie uma exception para previnir este problema d3e saída de
dados.

create table produto (id_prod number(3) primary key,
                      nome_prod varchar(20), dt_fab date);

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
			DBMS_OUTPUT.PUT_LINE ('Não há nenhum produto com este código');
END;


procedure:

CREATE OR REPLACE PROCEDURE nome_procedure
(argumento1 IN | OUT |IN OUT tipo_de_dados,
argumento2 IN | OUT |IN OUT tipo_de_dados,
...
argumentoN IN | OUT |IN OUT tipo_de_dados) IS | AS
variáveis locais, constantes, ...
BEGIN
...
END nome_procedure;

IN (padrão): Passa um valor do ambiente chamador para procedure e este
valor não pode ser alterado dentro dela (passagem de parâmetro por valor).
OUT: Passa um valor da procedure para o ambiente chamador (passagem de
parâmetro por referência).
IN OUT: Passa um valor do ambiente chamador para a procedure. Esse valor
pode ser alterado dentro da procedure e retornar com o valor atualizado para
o ambiente chamador (passagem de parâmetro por referência).
Nota: As palavras-chave IS ou AS (após a declaração dos parâmetros) podem ser
utilizadas, pois nesse contexto são equivalentes.

Exemplo:

drop table aluno cascade constraints;
create table aluno ( ra char(2) primary key,
                     nome varchar(20));
insert into aluno values('1','Marcel');
insert into aluno values('2','Silmara');
commit;
select * from aluno;

set serveroutput on

CREATE OR REPLACE PROCEDURE PROC_NOME_ALUNO (P_RA IN CHAR) 
IS
V_NOME VARCHAR2(50);
BEGIN
SELECT NOME INTO V_NOME
FROM ALUNO
WHERE RA = P_RA;
DBMS_OUTPUT.PUT_LINE (V_NOME);
END PROC_NOME_ALUNO;

Chamada, execução:
EXEC PROC_NOME_ALUNO(1);
