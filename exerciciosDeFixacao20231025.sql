CREATE DATABASE exercicios_trigger;
USE exercicios_trigger;

-- Criação das tabelas
CREATE TABLE Clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL
);

CREATE TABLE Auditoria (
    id INT AUTO_INCREMENT PRIMARY KEY,
    mensagem TEXT NOT NULL,
    data_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    estoque INT NOT NULL
);

CREATE TABLE Pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    produto_id INT,
    quantidade INT NOT NULL,
    FOREIGN KEY (produto_id) REFERENCES Produtos(id)
);

CREATE TRIGGER colocar_cliente 
ON Clientes AFTER INSERT
BEGIN
    INSERT INTO Auditoria(data_hora)
    VALUES ('07/07/2022 09:00')
END;

CREATE TRIGGER apagar_cliente
BEFORE DELETE ON Clientes FOR EACH ROW
BEGIN
    INSERT INTO Audiotoria
    VALUES CONCAT('Foi tentado apagar um nome')
END;

CREATE TRIGGER mudar_nome_cliente
AFTER UPDATE ON Clientes FOR EACH ROW
BEGIN
    IF nome.novo <> nome.velho THEN
        INSERT INTO Auditoria
        VALUES CONCAT(nome.novo, nome.velho);
END;

DELIMITER //
CREATE TRIGGER atualizacao_cliente
BEFORE UPDATE ON Clientes FOR EACH ROW
BEGIN
    IF (nome.novo OR nome.velho IS NULL)
    INSERT INTO Auditoria
    VALUES CONCAT('O campo do nome não pode ser vazio')
END;
//
DELIMITER;

DELIMITER //
CREATE TRIGGER novo_pedido
AFTER INSERT ON Pedidos FOR EACH ROW
BEGIN
        INSERT INTO Auditoria
        VALUES CONCAT('Estoque baixo para o produto ')
END;
//
DELIMITER; 
