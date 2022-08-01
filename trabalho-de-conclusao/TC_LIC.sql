create table LIC_CIDADE
(
  idcidade INTEGER not null,
  nome     VARCHAR(100) not null,
  uf       VARCHAR(2) not null
);

create table LIC_CLASSE_MATERIAL
(
  idclasse_material INTEGER not null,
  codigo            NUMERIC(4) not null,
  nome              VARCHAR(256) not null,
  grupo             VARCHAR(256) not null
);

create table LIC_CONTRATANTE
(
  idcontratante INTEGER not null,
  nome          VARCHAR(512) not null,
  idcidade      INTEGER not null,
  esfera        CHAR(1) not null
);

create table LIC_EMPRESA
(
  idempresa         INTEGER not null,
  nome              VARCHAR(128) not null,
  idcidade          INTEGER not null,
  cnpj              VARCHAR(20),
  faturamento_anual NUMERIC(12,2) not null,
  data_abertura     DATE,
  situacao          CHAR(1) not null,
  cpf               VARCHAR(20),
  tipo_pessoa       CHAR(1) default 'J' not null
);

create table LIC_LICITACAO
(
  idlicitacao        INTEGER not null,
  idcontratante      INTEGER not null,
  titulo             VARCHAR(100) not null,
  modalidade         CHAR(1) not null,
  tipo_selecao       CHAR(1) not null,
  procedimento       CHAR(1) not null,
  data_fechamento    DATE not null,
  inicio_vigencia    DATE,
  fim_vigencia       DATE,
  situacao           CHAR(1) not null,
  valor_estimado_min NUMERIC(12,2) not null,
  valor_estimado_max NUMERIC(12,2) not null,
  valor_homologado   NUMERIC(12,2) not null
);

create table LIC_MATERIAL
(
  idmaterial        INTEGER not null,
  nome              VARCHAR(756) not null,
  idclasse_material INTEGER,
  codigo            INTEGER
);

create table LIC_ITEM_LICITACAO
(
  iditem_licitacao INTEGER not null,
  idlicitacao      INTEGER not null,
  idmaterial       INTEGER not null,
  quantidade       NUMERIC(9,3) not null,
  observacao       VARCHAR(256),
  valor_minimo     NUMERIC(12,2) not null,
  valor_maximo     NUMERIC(12,2) not null,
  valor_homologado NUMERIC(12,2) not null
);

create table LIC_PROPOSTA
(
  idproposta     INTEGER not null,
  idlicitacao    INTEGER not null,
  idempresa      INTEGER not null,
  situacao       CHAR(1) default 'A' not null,
  data_inscricao DATE,
  valor_inicial  NUMERIC(12,2),
  valor_final    NUMERIC(12,2)
);

create table LIC_PROPOSTA_ITEM
(
  idproposta_item  INTEGER not null,
  valor_unitario   NUMERIC(9,2) not null,
  idproposta       INTEGER not null,
  iditem_licitacao INTEGER not null
);


alter table LIC_CIDADE
  add constraint PK_LIC_CIDADE primary key (IDCIDADE);

create index IX_CLASSE_MATERIAL on LIC_CLASSE_MATERIAL (GRUPO, IDCLASSE_MATERIAL);
alter table LIC_CLASSE_MATERIAL
  add constraint PK_CLASSE_MATERIAL primary key (IDCLASSE_MATERIAL);


create unique index PK_CONTRATANTE on LIC_CONTRATANTE (IDCONTRATANTE);
alter table LIC_CONTRATANTE
  add constraint PK_LIC_CONTRATANTE primary key (IDCONTRATANTE);
alter table LIC_CONTRATANTE
  add constraint FK_LIC_CONTRATANTE_LIC_CIDADE foreign key (IDCIDADE)
  references LIC_CIDADE (IDCIDADE);
alter table LIC_CONTRATANTE
  add check (esfera IN(
        'E',
        'F',
        'M'
    ));


create unique index PK_EMPRESA on LIC_EMPRESA (IDEMPRESA);
alter table LIC_EMPRESA
  add constraint PK_LIC_EMPRESA primary key (IDEMPRESA);
alter table LIC_EMPRESA
  add constraint FK_LIC_EMPRESA_LIC_CIDADE foreign key (IDCIDADE)
  references LIC_CIDADE (IDCIDADE);


alter table LIC_LICITACAO
  add constraint PK_LICITACAO primary key (IDLICITACAO);
alter table LIC_LICITACAO
  add constraint FK_LICITACAO_CONTRATANTE foreign key (IDCONTRATANTE)
  references LIC_CONTRATANTE (IDCONTRATANTE);



create index IX_MATERIAL_CLASSE on LIC_MATERIAL (IDCLASSE_MATERIAL);
alter table LIC_MATERIAL
  add constraint PK_LIC_MATERIAL primary key (IDMATERIAL);
alter table LIC_MATERIAL
  add constraint UK_CLASSE_MATERIAL_CODIGO unique (CODIGO);
alter table LIC_MATERIAL
  add constraint FK_MATERIAL_CLASSE foreign key (IDCLASSE_MATERIAL)
  references LIC_CLASSE_MATERIAL (IDCLASSE_MATERIAL);


alter table LIC_ITEM_LICITACAO
  add constraint PK_ITEM_LICITACAO primary key (IDITEM_LICITACAO);
alter table LIC_ITEM_LICITACAO
  add constraint FK_ITEM_LICITACAO_LICITACAO foreign key (IDLICITACAO)
  references LIC_LICITACAO (IDLICITACAO);
alter table LIC_ITEM_LICITACAO
  add constraint FK_ITEM_LICITACAO_MATERIAL foreign key (IDMATERIAL)
  references LIC_MATERIAL (IDMATERIAL);



comment on column LIC_PROPOSTA.situacao
  is 'S: selecionada, D: desqualificada, N: não selecionada';
alter table LIC_PROPOSTA
  add constraint PK_PROPOSTA primary key (IDPROPOSTA);
alter table LIC_PROPOSTA
  add constraint FK_PROPOSTA_EMPRESA foreign key (IDEMPRESA)
  references LIC_EMPRESA (IDEMPRESA);
alter table LIC_PROPOSTA
  add constraint FK_PROPOSTA_LICITACAO foreign key (IDLICITACAO)
  references LIC_LICITACAO (IDLICITACAO);


alter table LIC_PROPOSTA_ITEM
  add constraint PK_PROPOSTA_ITEM primary key (IDPROPOSTA_ITEM);
alter table LIC_PROPOSTA_ITEM
  add constraint FK_PROPOSTA_ITEM_ITEM_LICITAC foreign key (IDITEM_LICITACAO)
  references LIC_ITEM_LICITACAO (IDITEM_LICITACAO);
alter table LIC_PROPOSTA_ITEM
  add constraint FK_PROPOSTA_ITEM_PROPOSTA foreign key (IDPROPOSTA)
  references LIC_PROPOSTA (IDPROPOSTA);


-----------------------------------------------------------------------------------

SELECT * FROM LIC_CIDADE
SELECT * FROM LIC_CLASSE_MATERIAL
SELECT * FROM LIC_CONTRATANTE
SELECT * FROM LIC_EMPRESA
SELECT * FROM LIC_LICITACAO
SELECT * FROM LIC_PROPOSTA
SELECT * FROM LIC_PROPOSTA_ITEM

### Exercício 1
Buscar todas as licitações (tabela: LICITACAO) onde a data início da vigência seja maior ou igual 01/01/2018 e  a data fim da vigência menor ou igual a 30/06/2018. Mostrar no Select a data de fechamento no formato ’01-jan-2020’.
OBS: Valor arredondado sem cases decimais. 

SELECT  (SELECT to_char(data_fechamento, 'DD-mon-YYYY') AS DATA_FECHAMENTO),
		round(valor_estimado_min),
		titulo,
		round(valor_estimado_max),
		round(valor_homologado)
FROM LIC_LICITACAO
WHERE (inicio_vigencia >= DATE '2018-01-01') AND (fim_vigencia <= DATE '2018-06-30')

### Exercício 2
Buscar das contratantes com ID 705 e 738 o valor médio mínimo e máximo. (tabela: LICITACAO)

SELECT --* 
		--((avg(valor_estimado_min)+avg(valor_estimado_max))/2)::numeric(12,2),
		
		avg(valor_estimado_min),
		avg(valor_estimado_max)
FROM LIC_LICITACAO
WHERE (idcontratante = 738) 

### Exercício 3
Buscar os 6 contratantes que mais tiveram registros. (tabela: LICITACAO)
SELECT * FROM LIC_LICITACAO

SELECT  L.idcontratante ,COUNT(1) AS "QTD_REGISTRO"
FROM LIC_LICITACAO L
GROUP BY L.idcontratante
ORDER BY COUNT(1) DESC
LIMIT 6

### Exercício 4
Buscar as propostas (tabela: PROPOSTA) onde a data da inscrição seja maior ou igual a 01/06/2018. Colocar a descrição da situação: S-> selecionada, D -> desqualificada, N -> não selecionada. 
Dica: estrutura de case.

SELECT
CASE situacao
	WHEN 'S' THEN 'S -> selecionada'
	WHEN 'D' THEN 'D -> desqualificada'
	WHEN 'N' THEN 'N -> não selecionada'
END situacao_description,
idlicitacao,
idempresa
FROM LIC_PROPOSTA
WHERE data_inscricao >= DATE '2018-06-01'

### Exercício 5 
Buscar de todas as propostas o Id da proposta o valor inicial e final sem casas decimais e sem arredondamento (tabela: PROPOSTA). 

SELECT  idproposta,
		(valor_inicial)::numeric(12,0),
		(valor_final)::numeric(12,0)
FROM LIC_PROPOSTA

### Exercício 6
Buscar o maior valor final (Sem casas decimais e sem arredondar) das propostas de cada licitação que foram selecionadas. 
(tabela: PROPOSTA) Ordenado o maior valor para o menor.

SELECT idlicitacao, (valor_final)::numeric(12,0) FROM LIC_PROPOSTA
WHERE situacao = 'S'
ORDER BY (valor_final)::numeric(12,0) DESC

### Exercício 7
Buscar todas as propostas do ano de 2018, agrupar por situação mês e ano e a contagem de quantas teve. (tabela: PROPOSTA)
Ordernar por mês e situação

SELECT  situacao,
		((EXTRACT(MONTH FROM data_inscricao)),(EXTRACT(YEAR FROM data_inscricao))),
		count(1)
FROM LIC_PROPOSTA
WHERE EXTRACT(YEAR FROM data_inscricao)=2018
GROUP BY (situacao,(EXTRACT(MONTH FROM data_inscricao)), (EXTRACT(YEAR FROM data_inscricao)))
ORDER BY (EXTRACT(MONTH FROM data_inscricao), situacao)

--SELECT COUNT(1)
--FROM LIC_PROPOSTA
--WHERE (situacao = 'S') and (EXTRACT(MONTH FROM data_inscricao)=1) and (EXTRACT(YEAR FROM data_inscricao)=2018)

### Exercício 8
Buscar todos os campo onde a classe dos materiais é 13 e onde no nome contem “ALTURA 925 MM”. (tabela: MATERIAL)

SELECT * 
FROM LIC_MATERIAL
WHERE (nome SIMILAR TO '%ALTURA 925 MM%') AND (idclasse_material = 13)

### Exercício 9
Buscar no item da licitação (Tabela: ITEM_LICITACAO), mostrar o valor mínimo total e máximo total (quantidade X valor mínimo e máximo), ordenando por Id licitação

SELECT * FROM LIC_ITEM_LICITACAO

SELECT  iditem_licitacao,
		idlicitacao,
		quantidade,
		valor_minimo,
		(quantidade*valor_minimo) as minimo_total,
		valor_maximo,
		(quantidade*valor_maximo) as maximo_total
FROM LIC_ITEM_LICITACAO
ORDER BY idlicitacao

### Exercício 10
Buscar todos contratantes e sua cidade. Filtrar pelo Estado de Pernambuco e Cidade de Recife. Converter esfera M – Municipal , E - Estadual

SELECT * FROM LIC_CIDADE
SELECT * FROM LIC_CONTRATANTE

SELECT  CO.idcontratante,
		CO.nome,
CASE esfera
	WHEN 'M' THEN 'M - Municipal'
	WHEN 'E' THEN 'E - Estadual'
END esfera_description,
CI.nome,
CI.uf
FROM LIC_CONTRATANTE CO
INNER JOIN LIC_CIDADE CI ON CO.idcidade = CI.idcidade
WHERE (CI.nome = 'Recife') AND (CI.uf = 'PE')

### Exercício 11
Trazer o nome da empresa e nome da cidade, onde o final do CNPJ seja igual a 86. (Usar as tabelas lic_empresa e lic_cidade)		

SELECT * FROM LIC_CIDADE
SELECT * FROM LIC_EMPRESA

SELECT  E.nome,
		CI.nome
FROM LIC_EMPRESA E
INNER JOIN LIC_CIDADE CI ON E.idcidade = CI.idcidade
WHERE (cnpj SIMILAR TO '%-86')

### Exercício 12
Buscar no item da licitação as licitações do ID 60, mostrar no select o nome do material (apenas os 20 primeiros caracteres), quantidade e o valor médio (entre valor mínimo e máximo) multiplicado pela quantidade. Ordene pela quantidade.

SELECT * FROM LIC_ITEM_LICITACAO
WHERE idlicitacao = 60
ORDER BY quantidade
SELECT * FROM LIC_MATERIAL

SELECT  SUBSTR(MA.nome,1,20) AS nome_material,
		quantidade,
		(((I.valor_minimo+I.valor_maximo)/2)*I.quantidade)::NUMERIC(11,2) AS valo_medio
FROM LIC_ITEM_LICITACAO I
INNER JOIN LIC_MATERIAL MA ON I.idmaterial=MA.idmaterial
WHERE I.idlicitacao = 60
ORDER BY I.quantidade

### Exercício 13
Buscar o título da licitação, início da vigência, quantidade, nome do material e nome da classe do material, onde o id contratante seja igual a 643 no mês de março de 2018 o fechamento.

SELECT * FROM LIC_LICITACAO
SELECT * FROM LIC_ITEM_LICITACAO
SELECT * FROM LIC_MATERIAL
SELECT * FROM LIC_CLASSE_MATERIAL

SELECT  L.titulo,
		L.inicio_vigencia,
		IL.quantidade,
		MA.nome,
		CM.nome
FROM LIC_LICITACAO L
INNER JOIN LIC_ITEM_LICITACAO IL ON IL.idlicitacao = L.idlicitacao
INNER JOIN LIC_MATERIAL MA ON MA.idmaterial = IL.idmaterial
INNER JOIN LIC_CLASSE_MATERIAL CM ON CM.idclasse_material = MA.idclasse_material
WHERE (L.idcontratante = 643) AND (EXTRACT(MONTH FROM data_fechamento)=03 AND EXTRACT(YEAR FROM data_fechamento)=2018)

### Exercício 14
Listar todas as propostas com o resultado da diferença entre o maior valor final e o menor e o número da licitação. Ordenar da maior diferença para a menor.

SELECT  idlicitacao,
		(max(valor_final)-min(valor_final)) AS diferenca
FROM LIC_PROPOSTA
GROUP BY idlicitacao
ORDER BY diferenca DESC

### Exercício 15
Listar os campos destacados abaixo de todas as propostas junto com os devidos relacionamentos.
* Id Proposta
* Data de inscrição da proposta
* Nome da Empresa
* Nome da Cidade da empresa
* Estado da Empresa
* CPF / CNPJ (Na mesma columa as duas informações qdo tem CNPJ apare o CNPJ e quando tem CPF aparece o CPF da empresa)
* Titulo da licitação
* Situação da licitação
* Quantidade de cada item da licitação
* Observação do item
* Nome do material do item

SELECT * FROM LIC_ITEM_LICITACAO
SELECT idclasse_material, count(1) FROM LIC_MATERIAL
GROUP BY idclasse_material
SELECT * FROM LIC_CIDADE
SELECT * FROM LIC_CLASSE_MATERIAL
SELECT * FROM LIC_CONTRATANTE
SELECT * FROM LIC_EMPRESA
SELECT * FROM LIC_LICITACAO
SELECT * FROM LIC_PROPOSTA
SELECT * FROM LIC_PROPOSTA_ITEM

SELECT  PR.idproposta,
		PR.data_inscricao,
		E.nome as EMPRESA,
		CI.nome AS CIDADE,
		CI.uf,
		(SELECT (E.cnpj IS NOT null) or (E.cpf IS NOT null)) as "cnpj/cpf",
		LI.titulo,
		LI.situacao,
		IL.quantidade,
		IL.observacao,
		MA.nome AS MATERIAL
FROM LIC_PROPOSTA PR
INNER JOIN LIC_EMPRESA E ON E.idempresa = PR.idempresa
INNER JOIN LIC_CIDADE CI ON CI.idcidade = E.idcidade
INNER JOIN LIC_LICITACAO LI ON LI.idlicitacao = PR.idlicitacao
INNER JOIN LIC_ITEM_LICITACAO IL ON IL.idlicitacao = LI.idlicitacao
INNER JOIN LIC_MATERIAL MA ON MA.idmaterial = IL.idmaterial


### Exercício 16
Selecionar todos os materiais que nunca foram incluídos numa licitação. Apenas a quantidade.






