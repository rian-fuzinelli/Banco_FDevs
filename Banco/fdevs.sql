-- 1) Cria o banco de dados, se ainda não existe
CREATE DATABASE IF NOT EXISTS MeuBancoDeProdutos;

-- 2) Usa o banco de dados criado
USE MeuBancoDeProdutos;

-- 3) Cria a tabela Production_Product, se ainda não existe
CREATE TABLE IF NOT EXISTS Production_Product (
    IDProduto INT NOT NULL AUTO_INCREMENT,  
    NomeProduto NVARCHAR(100) NOT NULL,  
    CustoPadrao DECIMAL(10, 2) NOT NULL, 
    PrecoLista DECIMAL(10, 2) NOT NULL, 
    UltimaAtualizacao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (IDProduto) 
);

-- 4) Insere o produto 'Smartphone' (somente se ainda não existir)
INSERT INTO Production_Product (NomeProduto, CustoPadrao, PrecoLista)
VALUES ('Smartphone', 200.00, 400.00);

-- 5) Insere o produto 'Mountain Bike Socks' (somente se ainda não existir)
INSERT INTO Production_Product (NomeProduto, CustoPadrao, PrecoLista)
VALUES ('Mountain Bike Socks', 10.00, 20.00);

-- Desativa o modo seguro temporariamente
SET SQL_SAFE_UPDATES = 0;

-- 6) Atualiza o preço de lista do produto 'Mountain Bike Socks' para 15.00 (caso exista)
UPDATE Production_Product
SET PrecoLista = 15.00
WHERE NomeProduto = 'Mountain Bike Socks';

-- 7) Recupera os nomes e preços dos cinco produtos mais caros
SELECT NomeProduto, PrecoLista
FROM Production_Product
ORDER BY PrecoLista DESC
LIMIT 5;

-- 8) Seleciona o produto 'Smartphone'
SELECT NomeProduto, CustoPadrao, PrecoLista, UltimaAtualizacao
FROM Production_Product
WHERE NomeProduto = 'Smartphone';

-- INTERMEDIÁRIO --

-- 9) Consulta para recuperar nome do produto, categoria e quantidade em estoque
SELECT 
    p.NomeProduto,
    pi.QuantidadeEmEstoque
FROM 
    Production_Product p
JOIN 
    Production_ProductInventory pi ON p.IDProduto = pi.IDProduto
WHERE 
    p.NomeProduto = 'Smartphone';
    
-- 10) Exclui todos os produtos da categoria 'Clothing'
SET SQL_SAFE_UPDATES = 0;

DELETE FROM Production_Product
WHERE IDCategoria IN (
    SELECT IDCategoria FROM Production_ProductCategory WHERE NomeCategoria = 'Clothing'
);

-- 11) Criar a tabela Customer, se ainda não existir
CREATE TABLE IF NOT EXISTS Customer (
    IDCliente INT NOT NULL AUTO_INCREMENT,
    Titulo NVARCHAR(10),                  
    PrimeiroNome NVARCHAR(50) NOT NULL, 
    MeioInicial NVARCHAR(1),             
    UltimoNome NVARCHAR(50) NOT NULL,    
    PRIMARY KEY (IDCliente)             
);

-- 12) Insere alguns clientes de exemplo
INSERT INTO Customer (Titulo, PrimeiroNome, MeioInicial, UltimoNome)
VALUES 
('Sr.', 'Rian', 'C', 'Fuzinelli'),
('Sra.', 'Olivia', NULL, 'Schmidt'),
(NULL, 'Giorgio', 'A', 'Melassi');

-- 13) Consulta para recuperar a lista única de nomes completos
SELECT 
    CONCAT(
        COALESCE(CONCAT(Titulo, ' '), ''),
        PrimeiroNome, ' ',
        COALESCE(CONCAT(MeioInicial, '. '), ''),
        UltimoNome
    ) AS NomeCompleto
FROM 
    Customer;
