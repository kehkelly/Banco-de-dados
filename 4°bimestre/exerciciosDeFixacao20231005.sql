DELIMITER //
create function total_livros_por_genero (p_genero varchar(50)) 
returns int
deterministic
begin
    declare Ltotal int;
    declare done int default 0;
    declare id_livro int;
    declare cursor_genero cursor for select id_livro from livros where genero = p_genero;
    set Ltotal = 0;
    open cursor_genero;
    fetch_loop: loop
        fetch cursor_genero into id_livro;
        if done = 1 then leave fetch_loop;
        end if;
        set Ltotal =  Ltotal + 1;
    end loop;
    close cursor_genero;
    return Ltotal;
end;
//
DELIMITER ;

DELIMITER //
create function listar_livros_por_autor(p_nome varchar(50), u_nome varchar(50))
returns text
begin
    declare livros text;
    declare done int default 0;
    declare id_livro int;
    declare cursor_autor cursor for select id_livro from Livro_Autor 
    where primeiro_nome and ultimo_nome = p_nome and u_nome;
    set livros = '';
    open cursor_autor;
        fetch_loop: loop
            fetch cursor_autor into livro_id;
            if done = 1 then
                leave fetch_loop;
            end if;
            declare titulos varchar(250);
            declare cursor_livro cursor for select Titulo from Livro
            where id = livro_id;
            open cursor_livro;
            fetch cursor_livro into livro_titulo;
            close cursor_livro;
            set lista_de_livros = concat(lista_de_livros, livro_titulo, ', ');
        end loop;
    close cursor_autor;
    return livros
end;
//
DELIMITER ;