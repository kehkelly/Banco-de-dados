delimiter //
create procedure sp_ListarAutores ()
begin
select Nome from autor;
end
//

call sp_ListarAutores ();