CREATE TRIGGER after_auditoria_insert AFTER INSERT ON Clientes FOR EACH ROW
INSERT INTO Auditoria(mensagem) VALUES ('Inserção');
INSERT INTO Clientes (nome) VALUES ('Carlos');
SELECT * fROM Auditoria;

CREATE TRIGGER before_cliente_delete BEFORE DELETE ON Clientes FOR EACH ROW
INSERT INTO Auditoria(mensagem) VALUES ('Exclusão');
DELETE FROM Clientes WHERE id = 3;
SELECT * FROM Clientes;
