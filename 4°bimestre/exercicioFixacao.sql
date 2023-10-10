create database funcao_em_mysql;
use funcao_em_mysql;
create table nomes (
id_nomes int primary key not null auto_increment,
nome varchar(50)
);
insert into nomes (nome) values
("Roberta"), ("Roberto"), ("Maria Clara"), ("Jaõo")
;
select upper(nome) from nomes;
select length(nome) from nomes;
select nome 
case
when nome like '%o' then concat('Sr. ', nome)
else then concat('Sra. ', nome)
end
from nomes;