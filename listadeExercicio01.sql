select titulo from livros;

select nome from autores 
where nascimento < '1900-01-01';

select livros.titulo, autores.nome
from livros 
left join autores on autor.id = livros.autor_id;

