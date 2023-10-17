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
select nome,
case
	when nome like '%o' then concat('Sr. ', nome)
	else concat('Sra. ', nome)
end
from nomes;

create table produtos (
	id_produto int primary key auto_increment,
	produto varchar(70),
	preco int,
	qtd int 
);

insert into produtos (produto, preco, qtd) values
	('Produto A', 502.034, 3),
	('Produto B', 15019.90, 9),
	('Produto C', 800.56, 22)
;
select round(preco, 2) from produtos;
select abs(qtd) from produtos;
select avg(preco) from produtos;

create table eventos (
	id_eventos  int primary key auto_increment,
	data_evento datetime
)
;

insert into eventos (data_evento) values 
	('1992-12-22 22:34:32'), 
	('2001-04-19 14:02:13'),
	('2014-11-15 09:13:17'),
	(now())
;

select datediff('1992-12-22 22:34:32', '2014-11-15 09:13:117') from eventos;
select dayname('2001-04-19 14:02:123') from eventos;
select dayname('2014-11-15 09:13:117') from eventos;
select dayname('1992-12-22 22:34:32') from eventos;

select qtd,
  if(qtd > 0, 'Em estoque', 'Fora de estoque') as status
from produtos;

select produto, qtd,
case 
	when qtd<600 then produto='Barato'
	when qtd>600 and qtd<1000 then produto='Médio'
	else produto= 'Caro'
end
from produtos;

select produto, qtd,
  case 
    when preco < 600 then "Barato"
    when preco > 600 and preco < 1000 then "Médio"
    else "Caro"
  end as categoria_preco
from produtos;

DELIMITER //

create function TOTAL_VALOR(preco decimal(10, 2), qtd int)
returns decimal(10, 2)
deterministic
begin
	declare total decimal(10, 2);
    set total = preco * qtd;
    return total;
end;
//
DELIMITER ;

select * total_valor(preco, qtd) as valor_total from produtos;
    
select count(produto) from produtos;
select max(preco) from produtos;
select min(preco) from produtos;

select sum(if(qtd > 0, preco * qtd, 0)) as soma_total
from produtos;

DELIMITER //
create function Fatorial(n int) returns int
deterministic
begin
    declare result int;
    
    IF n <= 1 then 
		return 1;
    else
		set result = n * Fatorial(n - 1);
        return result;
    end if;
end;
//
DELIMITER;


DELIMITER //
create function exponencial(base decimal(10, 2), exponent INT) returns 
decimal(10, 2)
deterministic
begin
    declare result decimal(10, 2);
    set result = POW(base, exponent);
    return result;
end;
//
DELIMITER ;

DELIMITER //
create function is_palindromo(str varchar(255)) 
returns int
deterministic
begin
    declare reversed_str varchar(255);
    set str = replace(lower(str), ' ', '');
    set reversed_str = reverse(str);
    if str = reversed_str then
        return 1;
    else
        return 0;
    end if;
end;
//
