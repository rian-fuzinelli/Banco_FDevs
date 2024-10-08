-- 1) Criar o banco de dados, se ainda não existir
CREATE DATABASE IF NOT EXISTS MeuBancoDeProdutos;

-- 2) Usar o banco de dados criado
USE MeuBancoDeProdutos;

-- 3) Criar a tabela Production_Product, se ainda não existir
CREATE TABLE IF NOT EXISTS Production_Product (
    IDProduto INT NOT NULL AUTO_INCREMENT,  -- Campo ID com auto-incremento
    NomeProduto NVARCHAR(100) NOT NULL,    -- Nome do produto
    CustoPadrao DECIMAL(10, 2) NOT NULL,   -- Custo padrão do produto
    PrecoLista DECIMAL(10, 2) NOT NULL,    -- Preço de lista do produto
    UltimaAtualizacao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Data de última atualização
    PRIMARY KEY (IDProduto) -- Definir a chave primária
);

-- 4) Inserir o produto 'Smartphone' (somente se ainda não existir)
INSERT INTO Production_Product (NomeProduto, CustoPadrao, PrecoLista)
VALUES ('Smartphone', 200.00, 400.00);

-- 5) Inserir o produto 'Mountain Bike Socks' (somente se ainda não existir)
INSERT INTO Production_Product (NomeProduto, CustoPadrao, PrecoLista)
VALUES ('Mountain Bike Socks', 10.00, 20.00);

-- 6) Atualizar o preço de lista do produto 'Mountain Bike Socks' para 15.00 (caso exista)
UPDATE Production_Product
SET PrecoLista = 15.00
WHERE NomeProduto = 'Mountain Bike Socks';

-- 7) Recuperar os nomes e preços dos cinco produtos mais caros
SELECT NomeProduto, PrecoLista
FROM Production_Product
ORDER BY PrecoLista DESC
LIMIT 5;

-- 8) Selecionar o produto 'Smartphone'
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
    
-- 10) Excluir todos os produtos da categoria 'Clothing'
SET SQL_SAFE_UPDATES = 0;

DELETE FROM Production_Product
WHERE IDCategoria IN (
    SELECT IDCategoria FROM Production_ProductCategory WHERE NomeCategoria = 'Clothing'
);

-- 11) Criar a tabela Customer, se ainda não existir
CREATE TABLE IF NOT EXISTS Customer (
    IDCliente INT NOT NULL AUTO_INCREMENT,  -- Campo ID do cliente com auto-incremento
    Titulo NVARCHAR(10),                   -- Título do cliente (Ex: Sr., Sra., etc.)
    PrimeiroNome NVARCHAR(50) NOT NULL,    -- Primeiro nome do cliente
    MeioInicial NVARCHAR(1),               -- Inicial do meio nome
    UltimoNome NVARCHAR(50) NOT NULL,      -- Último nome do cliente
    PRIMARY KEY (IDCliente)                -- Definir a chave primária
);

-- 12) Inserir alguns clientes de exemplo
INSERT INTO Customer (Titulo, PrimeiroNome, MeioInicial, UltimoNome)
VALUES 
('Sr.', 'Rian', 'C', 'Fuzinelli'),
('Sra.', 'Olivia', NULL, 'Schmidt'),
(NULL, 'Giorgio', 'A', 'Melassi');

-- 13) Consulta para recuperar a lista única de nomes completos
SELECT 
    CONCAT(
        CASE WHEN Titulo IS NOT NULL THEN CONCAT(Titulo, ' ') ELSE '' END,
        PrimeiroNome, ' ',
        CASE WHEN MeioInicial IS NOT NULL THEN CONCAT(MeioInicial, '. ') ELSE '' END,
        UltimoNome
    ) AS NomeCompleto
FROM 
    Customer;