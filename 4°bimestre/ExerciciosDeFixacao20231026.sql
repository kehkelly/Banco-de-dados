CREATE TRIGGER after_auditoria_insert AFTER INSERT ON Clientes FOR EACH ROW
INSERT INTO Auditoria(mensagem) VALUES ('Inserção');
INSERT INTO Clientes (nome) VALUES ('Carlos');
SELECT * fROM Auditoria;

CREATE TRIGGER before_cliente_delete BEFORE DELETE ON Clientes FOR EACH ROW
INSERT INTO Auditoria(mensagem) VALUES ('Exclusão');
DELETE FROM Clientes WHERE id = 3;
SELECT * FROM Auditoria;

CREATE TRIGGER after_cliente_update AFTER UPDATE ON Clientes FOR EACH ROW
INSERT INTO Auditoria (mensagem, nome_antigo, nome_novo) VALUES ('update', OLD.nome, NEW.nome);
UPDATE Clientes SET nome = 'Phan' WHERE id = 2;
SELECT * FROM Clientes;
SELECT * FROM Auditoria;

CREATE TRIGGER cancel_cliente_update BEFORE UPDATE ON Clientes FOR EACH ROW
IF (NEW.nome IS NULL OR NEW.nome = '') THEN
    INSERT INTO Auditoria (mensagem, nome_antigo, nome_novo) VALUES ('Tentativa de atualização inválida', OLD.nome, NEW.nome);
    SET NEW.nome = OLD.nome;
END IF;

