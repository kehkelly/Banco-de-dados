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

