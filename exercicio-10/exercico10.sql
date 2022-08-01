SELECT * FROM DEPARTAMENTO
SELECT * FROM EMPREGADO
where iddepartamento is not null
order by salario

# Lista de Exercícios 10

## Exercício 1
### Múltiplos acessos
Liste o nome do empregado, o nome do gerente e o departamento de cada um.

SELECT nomeempregado,
	   E.idempregado,
	   E.idgerente AS GERENTE,
	   D.nomedepartamento,
	   E.iddepartamento

FROM EMPREGADO E
INNER JOIN DEPARTAMENTO D ON E.iddepartamento = D.iddepartamento


## Exercício 2
### Maior Salário
Liste o departamento (id e nome) com o empregado de maior salário.

SELECT D.iddepartamento,
	   D.nomeDepartamento
FROM EMPREGADO E
INNER JOIN DEPARTAMENTO D ON E.iddepartamento = D.iddepartamento
WHERE E.salario = (SELECT max(salario) FROM EMPREGADO WHERE iddepartamento IS NOT NULL)

## Exercício 3
### Conflito
Adicione uma Unique Constraint ao atributo nome departamento de departamento.
Em seguida adicione um novo departamento de vendas e faça com que o anterior mude de novo. OBS: em apenas um comando.
Dica: pesquisar por on conflict

SELECT * FROM DEPARTAMENTO
--Delete from DEPARTAMENTO
--Where nomedepartamento = 'Vendas';
--UPDATE DEPARTAMENTO
--SET nomedepartamento = 'Vendas'
 --where iddepartamento = 30;
CREATE UNIQUE INDEX idx_nomedepartamento ON DEPARTAMENTO(iddepartamento, iddepartamento)
ALTER TABLE DEPARTAMENTO 
ADD CONSTRAINT nome_departamento UNIQUE (nomedepartamento);
INSERT INTO DEPARTAMENTO(iddepartamento, nomedepartamento, localizacao) VALUES (5, 'Vendas', 'EUA')
ON CONFLICT (nomedepartamento) 
DO UPDATE SET nomedepartamento = 'Vendas';

## Exercício 4
### Cidades duplicadas
Liste todas as cidades duplicadas (Tabela: CidadeEX) (nome e UF iguais e quantas ocorrência tem na tabela.

SELECT C.NOME,
	   COUNT(C.NOME) AS QTD_NOME,
	   COUNT(C.UF) AS QTD_UF 
FROM CIDADEEX C
GROUP BY (C.NOME,C.UF);

## Exercício 5
### Definindo Cidades
Faça uma alteração nas cidades (Tabela: CidadeEX) que tenham nome+UF duplicados, adicione no final do nome um asterisco. Mas atenção! Apenas a cidade com maior ID deve ser alterada.

SELECT MAX(IDCIDADE),
	   NOME,
	   UF
FROM CIDADEEX
GROUP BY NOME,UF 
HAVING COUNT(NOME)>1 AND COUNT(UF)>1 
ORDER BY NOME;

UPDATE CIDADEEX
SET NOME = NOME || '*'
WHERE IDCIDADE = (SELECT MAX(IDCIDADE) FROM CIDADEEX)
SELECT * FROM CIDADEEX
order by IDCIDADE desc
												  
### Explicação adicional - VIEW
Para reaproveitar uma consulta SQL um dos recursos oferecidos é a criação de VIEWS. Neste recurso o comando SQL é salvo no dicionário de dados do SGBD e pode ser reutilizado novamente.
Um exemplo disso seria uma consulta que retorna apenas as cidades do RS.
													  
~~~sql
Create view vwCidades_Gauchas as
   Select IDCidade,
          Nome
   From   Cidade
   Where  UF = 'RS';
~~~

Para utilizar esta consulta ela deve ser referenciada no FROM como se fosse uma fonte de dados qualquer:

~~~sql
Select IDCidade, 
       Nome 
  From vwCidades_Gauchas;
~~~