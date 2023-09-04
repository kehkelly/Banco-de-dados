select titulo from livros;

select nome from autores 
where nascimento < '1900-01-01';

select livros.titulo, autores.nome
from livros 
left join autores on autor.id = livros.autor_id;

select alunos.nome, matriculas.curso
from alunos
inner join matriculas on alunos.id = matriculas.aluno_id;

select produto, sum(receita) as receita_total
from vendas
group by produto;

select livros, autores, count(1)
from livros
group by autores;

select alunos, curso from matriculas, count(1)
from matriculas
group by matriculas;

