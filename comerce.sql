CREATE database ecomerce;
use ecomerce;

CREATE TABLE sistema_vendas;
use sistema_vendas; 

CREATE TABLE produtos (
    id_produto INT PRIMARY KEY ,
    nome VARCHAR(100),
    categoria VARCHAR(50),
    preco DECIMAL(10, 2)
);  

CREATE TABLE vendas (
    id_venda INT PRIMARY KEY,
    id_produto INT,
    produto_nome_legacy VARCHAR(100),
    quantidade INT,
    valor_unitario DECIMAL(10, 2),
    data_venda DATE, 
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);

INSERT INTO produtos (nome, categoria, preco) VALUES
('Mouse Gamer', 'Periféricos', 150.00),
('Teclado Mecânico', 'Periféricos', 300.00),
('Teclado normal', 'Periféricos', 30.00),
('Monitor 24"', 'Monitores', 900.00);

INSERT INTO vendas (id_produto, produto_nome_legacy, quantidade, valor_unitario, data_venda) 
VALUES
(1, 'Mouse Gamer', 2, 150.00, '2026-03-15'),
(2, 'Teclado Mecânico', 1, 300.00, '2026-04-10'),
(3, 'Monitor 24"', 1, 900.00, CURDATE());

SELECT produto_nome_legacy, SUM(quantidade) AS total_qtd
FROM vendas 
GROUP BY produto_nome_legacy
ORDER BY total_qtd DESC 
LIMIT 1;

SELECT p.categoria, SUM(v.quantidade * p.preco) AS faturamento_categoria
FROM produtos p
INNER JOIN vendas v ON p.id_produto = v.id_produto
WHERE v.data_venda >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
GROUP BY p.categoria;	