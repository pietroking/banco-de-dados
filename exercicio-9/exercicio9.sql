SELECT * FROM CLIENTE

SELECT
		CASE WHEN STRPOS(nome,' ') >0 THEN
		LEFT(nome, STRPOS(nome,' '))
		ELSE nome END AS "primeiroNome", COUNT(1) AS "QuantidadeOcorrencia"
FROM CLIENTE
GROUP BY "primeiroNome"
ORDER BY COUNT(1) DESC
LIMIT 1

SELECT * FROM PEDIDO
SELECT COUNT(datapedido),
	   SUM(valorpedido)
FROM PEDIDO
WHERE (EXTRACT(MONTH FROM datapedido)= 03) AND (EXTRACT(YEAR FROM datapedido)= 2018);

SELECT * FROM CIDADE
(SELECT uf "UF", COUNT(1)
FROM CIDADE INNER JOIN CLIENTE ON CIDADE.idcidade = CLIENTE.idcidade
GROUP BY "UF"
ORDER BY COUNT(1) DESC
LIMIT 1)
UNION ALL
(SELECT uf "UF", COUNT(1)
FROM CIDADE INNER JOIN CLIENTE ON CIDADE.idcidade = CLIENTE.idcidade
GROUP BY "UF"
ORDER BY COUNT(1) ASC
LIMIT 1)

SELECT * FROM PRODUTO
ORDER BY idproduto desc
INSERT INTO produto(idproduto, nome, datacadastro, precocusto, precovenda, situacao)
			VALUES (8001, 'Coturno Pica-Pau', current_date, 29.25, 77.95, 'A');
			
SELECT nome FROM PRODUTO LEFT JOIN PEDIDOITEM ON PRODUTO.idproduto = PEDIDOITEM.idproduto
WHERE PEDIDOITEM.idpedido is null
ORDER BY PRODUTO.idproduto DESC

SELECT PEDIDOITEM.idproduto,
	   PRODUTO.nome,
	   SUM(PEDIDOITEM.precounitario*PEDIDOITEM.quantidade) as valorVenda
FROM PEDIDOITEM LEFT JOIN PEDIDO ON PEDIDOITEM.idpedido = PEDIDO.idpedido
LEFT JOIN PRODUTO ON PRODUTO.idproduto = PEDIDOITEM.idproduto
WHERE (EXTRACT(YEAR FROM PEDIDO.datapedido)=2018)
GROUP BY PRODUTO.nome, PEDIDOITEM.idproduto
ORDER BY valorVenda DESC
LIMIT 30







