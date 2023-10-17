DELIMITER //
create function total_livros_por_genero (genero varchar(50)) 
returns int
deterministic
begin
    declare Ltotal int;
    declare done int default 0;
    declare id_livro int;
    declare cursor_genero cursor for select id_livro from livros where genero = genero;
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
CREATE FUNCTION listar_livros_por_autor(p_nome VARCHAR(255), u_nome VARCHAR(255))
RETURNS TEXT
BEGIN
    DECLARE lista_de_livros TEXT;
    DECLARE done INT DEFAULT 0;
    DECLARE livro_id INT;
    DECLARE cursor_autor CURSOR FOR SELECT Livro_ID FROM Livro_Autor
    WHERE p_nome = primeiro_nome AND u_nome = ultimo_nome;
    SET lista_de_livros = '';
    OPEN cursor_autor;
    FETCH_LOOP: LOOP
        FETCH cursor_autor INTO livro_id;
        IF done = 1 THEN
            LEAVE FETCH_LOOP;
        END IF;
        DECLARE livro_titulo VARCHAR(255);
        DECLARE cursor_livro CURSOR FOR
        SELECT Titulo
        FROM Livro
        WHERE ID = id_livro;
        OPEN cursor_livro;
        FETCH cursor_livro INTO livro_titulo;
        CLOSE cursor_livro;
        SET lista_de_livros = CONCAT(lista_de_livros, livro_titulo, ', ');
    END LOOP;
    CLOSE cursor_autor;
    RETURN lista_de_livros;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE atualizar_resumos()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE livro_id INT;
    DECLARE resumo_atual TEXT;
    DECLARE novo_resumo TEXT;
    DECLARE cursor_atualização CURSOR FOR SELECT id, resumo FROM Livro;
    OPEN cursor_atualização;
    read_loop: LOOP
        FETCH cursor_atualização INTO livro_id, resumo_atual;
        IF done = 1 THEN
            LEAVE read_loop;
        END IF;
        SET novo_resumo = CONCAT(resumo_atual, ' Este é um excelente livro!');
        UPDATE Livro SET resumo = novo_resumo WHERE id = livro_id;
    END LOOP;
    CLOSE cursor_atualização;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE media_livros_por_editora()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE editora_id INT;
    DECLARE editora_nome VARCHAR(255);
    DECLARE total_livros INT;
    DECLARE media FLOAT;
    DECLARE editora_cursor CURSOR FOR SELECT id, nome FROM Editora;
    DECLARE livros_cursor CURSOR FOR SELECT EditoraId, COUNT(*) AS total FROM Livro
        GROUP BY EditoraId;
    CREATE TEMPORARY TABLE temp_media_livros (editora_id INT, total_livros INT);
    OPEN editora_cursor;
    read_editora_loop: LOOP
        FETCH editora_cursor INTO editora_id, editora_nome;
        IF done = 1 THEN
            LEAVE read_editora_loop;
        END IF;
        INSERT INTO temp_media_livros (editora_id, total_livros)
        VALUES (editora_id, 0);
    END LOOP;
    CLOSE editora_cursor;
    OPEN livros_cursor;
    read_livros_loop: LOOP
        FETCH livros_cursor INTO editora_id, total_livros;
        IF done = 1 THEN
            LEAVE read_livros_loop;
        END IF;
        UPDATE temp_media_livros
        SET total_livros = total_livros
        WHERE editora_id = id_editora;
    END LOOP;
    CLOSE livros_cursor;
    SELECT Editora.nome AS Editora, AVG(temp_media_livros.total_livros) AS Media
    FROM Editora
    JOIN temp_media_livros ON Editora.id = temp_media_livros.editora_id
    GROUP BY Editora.id;
    DROP TEMPORARY TABLE IF EXISTS temp_media_livros;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE autores_sem_livros()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE autor_id INT;
    DECLARE autor_nome VARCHAR(255);
    DECLARE cursor_sem_livro CURSOR FOR SELECT id, nome FROM Autor;
    CREATE TEMPORARY TABLE temp_autores_sem_livros (id_autor INT, autor_nome VARCHAR(255));
    OPEN cursor_sem_livro;
    read_autor_loop: LOOP
        FETCH autor_cursor INTO autor_id, autor_nome;
        IF done = 1 THEN
            LEAVE read_autor_loop;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM Livro_Autor WHERE AutorId = autor_id) THEN
            INSERT INTO temp_autores_sem_livros (autor_id, autor_nome)
            VALUES (autor_id, autor_nome);
        END IF;
    END LOOP;
    CLOSE cursor_sem_livro;
    SELECT * FROM temp_autores_sem_livros;
    DROP TEMPORARY TABLE IF EXISTS temp_autores_sem_livros;
END //
DELIMITER ;
