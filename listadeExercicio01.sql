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

select produto, avg(receita) from vendas
group by receita;

select produto from vendas
where receita > 10000.00;

select autores.nome, livros.titulo 
from livros
inner join livros on autores.id = livros.autor_id
group by autores 
where min(2);

select livros.titulo, autores.nome
from livros
inner join autores on livros.autor_id = autores.id;

select alunos, matriculas.curso
from matriculas
inner join alunos on alunos.id = matriculas.aluno_id;

select autores.nome as NomeAutor, livros.titulo as TituloLivro
from autores
left join livros on autores.id_autor = livros.id_autor;

select cursos.nome as NomeCurso, alunos.nome as NomeAluno
from cursos
rigth join alunos on cursos.id_curso = alunos.id_curso;

select alunos.nome as NomeAluno, cursos.nome as NomeCurso
from alunos
inner join cursos on alunos.id_curso = cursos.id_curso;

select autores.nome AS NomeAutor, count(livros.id_livro) as TotalLivrosPublicados
from autores
left join livros on autores.id_autor = livros.id_autor
group by autores.id_autor, autores.nome
order by TotalLivrosPublicados desc;

select produto, sum(valor) as ReceitaTotal
from vendas
group by produto
limit 1;

select autores.nome as NomeAutor, sum(20) as ReceitaTotal
from autores
left join livros on autores.id_autor = livros.id_autor
left join vendas on livros.id_livro = vendas.id_livro
group by autores.nome;

select aluno_id, count(*) as NumeroDeMatriculas
from matriculas
group by aluno_id;

select produto, count(*) as QuantidadeTransacoes
from transacoes
group by produto
order by QuantidadeTransacoes desc
limit 1;