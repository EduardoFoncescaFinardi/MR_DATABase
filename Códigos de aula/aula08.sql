-- aula 08 - 16/04/2024

-- exercício 1: migre os dados de uma tabela para outra tabela

drop table produto cascade constraints;

create table produto (
    cd_prod NUMBER(2) PRIMARY KEY,
    nome_prod varchar(20),
    preco number(10,2)
);

insert into produto values (1, 'Pneu', 350);
insert into produto values (2, 'Monitor', 1350);
insert into produto values (3, 'Mouse', 170);
insert into produto values (4, 'Água', 1.75);

drop table produto1 cascade constraints;

create table produto1(
    cd_prod number(2) primary key,
    nome_prod varchar(20),
    preco number(10,2)
);

select * from produto1;

declare 
    
    cursor c_migra is select * from produto;
    
begin   

    for v_migra in c_migra loop
        insert into produto1 values (v_migra.cd_prod, v_migra.nome_prod, v_migra.preco);
    
    end loop;
    commit;
end;

select * from produto1;

-- exercício 2: incluir os seguintes produtos na tabela produto
-- 5 - carvão - 35
-- 6 - ovos   - 20
-- 7 - ssd    - 1000

-- incluir os seguintes produtos na tabela produto1
-- 5 - amortecedor   - 358
-- 6 - cortina       - 120
-- 7 - quadro de luz - 650

-- Criar a tabela produto2 apenas com os produtos diferentes encontrados nas tabelas produto e produto1. Tente fazer com um programa apenas.

drop table produto2 cascade constraints;

create table produto2(
    cd_prod number(2) primary key,
    nome_prod varchar(20),
    preco number(10,2)
);

declare

begin
    insert into produto values (5, 'carvão', 35);
    insert into produto values (6, 'ovos', 20);
    insert into produto values (7, 'ssd', 1000);
    
    insert into produto1 values (5, 'amortecedor', 358);
    insert into produto1 values (6, 'cortina', 650);
    insert into produto1 values (7, 'quadro de luz', 650);
    
end;
