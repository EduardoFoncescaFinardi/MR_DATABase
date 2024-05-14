-- aula 11, 14/05/24 --

drop table funcionarios_tb1 cascade constraints;

create table funcionarios_tb1(
    primeiro_nome varchar(30),
    id number(2)
);

    insert into funcionarios_tb1 values ('Marcel', 10);
    insert into funcionarios_tb1 values ('Andrea', 20);
    insert into funcionarios_tb1 values ('Samuel', 90);
    commit;
    
CREATE OR REPLACE FUNCTION primeiro_nome_func
RETURN VARCHAR 
IS 
    emp_name VARCHAR(20);
BEGIN  
    SELECT primeiro_nome INTO emp_name FROM funcionarios_tb1
    WHERE ID = 90;
    RETURN emp_name;
END;

SELECT primeiro_nome_func FROM dual;

SELECT * FROM funcionarios_tb1;

--------------------------------------------------

CREATE OR REPLACE FUNCTION teste_soma (p1 IN NUMBER, p2 IN NUMBER)
RETURN NUMBER
is
soma number(4);
BEGIN
    soma := p1 + p2;
    return soma;
end;

select teste_soma(10,15) from dual;
select teste_soma(&valo1, &valor2) from dual;


---

set verify off
set serveroutput on 
declare
    n1 number(4) := &valor1;
    n2 n1%type := &valor2;
    re n1%type;
begin 
    re := teste_soma(n1, n2);
    dbms_output.put_line(re);
end;

------- exercício 1 -------------------------------

-- criar uma função que analise dois valores numéricos inteiros e retorne o maior deles.

CREATE OR REPLACE FUNCTION retorno_maior ( n1 IN NUMBER, n2 IN NUMBER)
RETURN NUMBER
is
maior number;
BEGIN
    IF n1 > n2 THEN
    maior := n1;
    
    ELSE
    maior := n2;
    END IF;
    RETURN maior;
END;

DECLARE 
    n1 number(4) := &valor1;
    n2 n1%type := &valor2;
    re n1%type;
BEGIN
    re := retorno_maior(n1, n2);
    dbms_output.put_line(re);
END;

------- exercício 2 -------------------------------
-- Criar uma função para exibir a fatorial de um número qualquer
-- OBS:  O fatorial de um número é a multiplicação desse número por todos os seus antecessores maiores que zero.




