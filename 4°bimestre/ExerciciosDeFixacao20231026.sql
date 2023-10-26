CREATE TRIGGER after_auditoria_insert AFTER INSERT ON Clientes FOR EACH ROW
INSERT INTO Auditoria(mensagem) VALUES ('Mensagem inserida');
INSERT INTO Clientes (nome) VALUES ('Carlos');
SELECT * from Auditoria;

