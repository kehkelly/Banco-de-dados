delimiter //
create procedure sp_ListarAutores ()
begin
select Nome from autor;
end
//
call sp_ListarAutores ();

create procedure sp_LivrosPorCategoria(in p_categoria varchar(255))
begin
    select * from livros where categoria = p_categoria;
end //
call sp_LivrosPorCategoria('Ficção Científica');
call sp_LivrosPorCategoria('Romance');
call sp_LivrosPorCategoria('Ciência');

create procedure sp_ContarLivrosPorCategoria(in p_categoria varchar(255), out @total_livros int)
begin
    select count(*) into total_livros from livros where categoria = p_categoria;
end //
call sp_ContarLivrosPorCategoria('Ficção', @total_livros);
select @total_livros;

create procedure sp_VerificarLivrosCategoria(in p_categoria varchar(255), out categoria_tem_livros boolean)
begin
    declare total_livros int;
    
    select count(*) into total_livros from livros where categoria = p_categoria;
    
    if total_livros > 0 then
        set categoria_tem_livros = TRUE;
    else
        set categoria_tem_livros = FALSE;
    end if;
end //
call sp_VerificarLivrosCategoria('Ficção', @categoria_tem_livros);
select @categoria_tem_livros;

create procedure sp_LivrosAteAno(in ano_param int)
begin
    select * from livros where ano_publicacao <= ano_param;
end //
call sp_LivrosAteAno(2007);

create procedure sp_TitulosPorCategoria(in p_categoria varchar(255))
begin
    select titulo from livros where categoria = p_categoria;
end //
call sp_TitulosPorCategoria('Ficção');

CREATE PROCEDURE sp_AdicionarLivro(
    in p_titulo varchar(255),
    in p_autor varchar(255),
    in p_ano_publicacao int,
    in p_categoria varchar(255),
    out resultado varchar(255))
begin
    declare livro_id int;
    select id into livro_id from Livro where titulo = p_titulo limit 1;
    if livro_id is not null then
        set resultado = 'O título já existe na tabela.';
    else
        insert into Livro (titulo, autor, ano_publicacao, categoria) values (p_titulo, p_autor, p_ano_publicacao, p_categoria);
        set resultado = 'Livro adicionado com sucesso.';
    end if;
end //
call sp_AdicionarLivro('Novo Livro', 'Autor Desconhecido', 2023, 'Ficção', @resultado);
select @resultado;

create procedure sp_AutorMaisAntigo(out nome_autor varchar(255))
begin
    select autor_nome
    into nome_autor
    from autores
    where autor_data_nascimento = (
        select min(autor_data_nascimento)
        from autores
    );
end //
call sp_AutorMaisAntigo(@nome_autor);
select @nome_autor;

create procedure sp_AdicionarLivro(
    in p_titulo varchar(255)         -- Parâmetro de entrada: título do livro
    in p_autor varcahr(255),         -- Parâmetro de entrada: autor do livro
    in p_ano_publicacao int,         -- Parâmetro de entrada: ano de publicação do livro
    in p_categoria varchar(255),     -- Parâmetro de entrada: categoria do livro
    out resultado varchar(255)       -- Parâmetro de saída: mensagem de resultado
)
begin
    declare livro_id int;  -- Declaração de uma variável local para armazenar o ID do livro

    -- Verifica se o título já existe na tabela
    select id into livro_id from Livro where titulo = p_titulo limit 1;

    -- Início do bloco condicional IF
    if livro_id is not null then
        -- Título já existe, retornar mensagem de erro
        set resultado = 'O título já existe na tabela.';
    else
        -- Título não existe, inserir o novo livro na tabela
        insert into Livro (titulo, autor, ano_publicacao, categoria)
        values (p_titulo, p_autor, p_ano_publicacao, p_categoria);
        
        -- Define a variável resultado com uma mensagem de sucesso
        set resultado = 'Livro adicionado com sucesso.';
    end if;
    -- Fim do bloco condicional IF
end //

create procedure sp_LivrosESeusAutores()
begin
    select Livro.titulo, concat(Autor.nome, ' ', Autor.sobrenome) as autor
    from Livro
    inner join Autor on Livro.autor_id = Autor.id;
end //
call sp_LivrosESeusAutores();