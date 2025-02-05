-- Criando o banco de dados
CREATE DATABASE Ecommerce;
USE Ecommerce;

-- Tabela Cliente
CREATE TABLE Cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    tipo ENUM('PF', 'PJ') NOT NULL,
    cpf_cnpj VARCHAR(20) UNIQUE NOT NULL,
    CHECK ( (tipo = 'PF' AND CHAR_LENGTH(cpf_cnpj) = 11) OR (tipo = 'PJ' AND CHAR_LENGTH(cpf_cnpj) = 14) )
);

-- Tabela Pedido
CREATE TABLE Pedido (
    id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    data_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Pendente', 'Pago', 'Cancelado') NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

-- Tabela Pagamento
CREATE TABLE Pagamento (
    id_pagamento INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT NOT NULL,
    tipo_pagamento ENUM('Cartão', 'Boleto', 'Pix') NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido)
);

-- Tabela Fornecedor
CREATE TABLE Fornecedor (
    id_fornecedor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL
);

-- Tabela Produto
CREATE TABLE Produto (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    id_fornecedor INT NOT NULL,
    FOREIGN KEY (id_fornecedor) REFERENCES Fornecedor(id_fornecedor)
);

-- Tabela Estoque
CREATE TABLE Estoque (
    id_estoque INT PRIMARY KEY AUTO_INCREMENT,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    FOREIGN KEY (id_produto) REFERENCES Produto(id_produto)
);

-- Tabela Entrega
CREATE TABLE Entrega (
    id_entrega INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT NOT NULL,
    status ENUM('Enviado', 'Em trânsito', 'Entregue') NOT NULL,
    codigo_rastreio VARCHAR(50) UNIQUE NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido)
);
