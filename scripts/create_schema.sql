-- =============================
-- 🧴 Nawt's Life - Modelo OLTP
-- SQL Server - Criação de Tabelas
-- =============================

CREATE TABLE Posicao (
    idPosicao INT PRIMARY KEY,
    posicao VARCHAR(50) NOT NULL,
    comissao REAL NOT NULL
);

CREATE TABLE Revendedor (
    idRevendedor INT PRIMARY KEY,
    idPosicao INT NOT NULL,
    idSuperior INT NULL,
    FOREIGN KEY (idPosicao) REFERENCES Posicao(idPosicao),
    FOREIGN KEY (idSuperior) REFERENCES Revendedor(idRevendedor)
);

CREATE TABLE Periodo (
    idPeriodo BIGINT PRIMARY KEY,
    periodo BIGINT NOT NULL,
    dataInicial DATE NOT NULL,
    dataFinal DATE NOT NULL,
    status SMALLINT NOT NULL
);

CREATE TABLE Produto (
    idProduto INT PRIMARY KEY,
    produto VARCHAR(100) NOT NULL,
    preco REAL NOT NULL,
    dataAtualizacao DATE
);

CREATE TABLE Pedido (
    idPedido INT PRIMARY KEY,
    idRevendedor INT NOT NULL,
    dataPedido INT NOT NULL,
    FOREIGN KEY (idRevendedor) REFERENCES Revendedor(idRevendedor)
);

CREATE TABLE PedidoItem (
    idPedido BIGINT NOT NULL,
    idProduto BIGINT NOT NULL,
    dataDevolucao DATE NULL,
    PRIMARY KEY (idPedido, idProduto),
    FOREIGN KEY (idPedido) REFERENCES Pedido(idPedido),
    FOREIGN KEY (idProduto) REFERENCES Produto(idProduto)
);

CREATE TABLE Estoque (
    idEstoque BIGINT PRIMARY KEY,
    idRevendedor BIGINT NOT NULL,
    idPeriodo BIGINT NOT NULL,
    FOREIGN KEY (idRevendedor) REFERENCES Revendedor(idRevendedor),
    FOREIGN KEY (idPeriodo) REFERENCES Periodo(idPeriodo)
);

CREATE TABLE EstoqueItens (
    idEstoque BIGINT NOT NULL,
    idProduto BIGINT NOT NULL,
    PRIMARY KEY (idEstoque, idProduto),
    FOREIGN KEY (idEstoque) REFERENCES Estoque(idEstoque),
    FOREIGN KEY (idProduto) REFERENCES Produto(idProduto)
);

CREATE TABLE Acerto (
    idPedido BIGINT NOT NULL,
    valor BIGINT NOT NULL,
    dataAcerto BIGINT NOT NULL,
    idPeriodo BIGINT NOT NULL,
    PRIMARY KEY (idPedido, valor, dataAcerto),
    FOREIGN KEY (idPedido) REFERENCES Pedido(idPedido),
    FOREIGN KEY (idPeriodo) REFERENCES Periodo(idPeriodo)
);