/*
  Projeto Crescer - Treinamento de banco de dados 
  ---
  Laboratório 1: Comandos DDL, criação de tabelas e constraints.  
*/

Create table CidadeEX
(
  IDCidade  int         not null,
  Nome      varchar(30) not null,
  UF        varchar(2)  not null,
    constraint PK_CidadeEX1 primary key (IDCidade)
);	

Create table AssociadoEX
(
  IDAssociado    int         not null,
  Nome           varchar(50) not null,
  DataNascimento date    not null,
  Sexo           char(1)     not null,
  CPF            varchar(11) ,
  Endereco       varchar(35),
  Bairro         varchar(25),
  Complemento    varchar(20),
  IDCidade       int,
     constraint PK_AssociadoEX primary key (IDAssociado),
	 constraint FK_AssociadoEX foreign key (IDCidade)
	    references CidadeEX (IDCidade)
);

SELECT * FROM CidadeEX

create table CidadeAux
as
Select * from CidadeEx;

TRUNCATE TABLE CidadeAux

INSERT INTO CidadeAux (IDCidade, Nome, UF)
	SELECT IDCidade, Nome, 'RS'
	FROM CidadeEX
	WHERE UF = 'RS';

Delete from CidadeAux
Where uf != 'RJ';

SELECT * FROM CidadeAux

CREATE TABLE EstoqueEx(
	idEstoque INTEGER UNIQUE NOT NULL PRIMARY KEY,
	nomeEstoque VARCHAR(255) NOT NULL,
	dataCriacao DATE NOT NULL,
	capacidade NUMERIC(6,0) NOT NULL
);

insert into EstoqueEx (idEstoque, nomeEstoque, dataCriacao, capacidade)
   values (1, 'VALHALLA', CURRENT_DATE, 123456);
   
SELECT * FROM EstoqueEx

CREATE TABLE ProdutoEx(
	idProduto INTEGER NOT NULL PRIMARY KEY,
	nomeProduto VARCHAR(255) NOT NULL,
	descProduto VARCHAR(255) NOT NULL,
	dtCriacao DATE NOT NULL,
	quantidade INTEGER,
	preco NUMERIC(6,2) NOT NULL,
	idEstoque INTEGER,
	FOREIGN KEY (idEstoque) REFERENCES EstoqueEx(idEstoque)
);

insert into ProdutoEx (idProduto, nomeProduto, descProduto, dtCriacao, quantidade, preco, idEstoque)
   values (1, 'JORDAN', 'TENIS', to_date('10/05/2021','DD/MM/YYYY'), 12, 699.99, 1);
insert into ProdutoEx (idProduto, nomeProduto, descProduto, dtCriacao, quantidade, preco, idEstoque)
   values (2, 'LEBRON', 'TENIS', to_date('10/05/2021','DD/MM/YYYY'), 10, 800, 1);
   
SELECT * FROM ProdutoEx

UPDATE AssociadoEX
SET CPF = 00000000000,
	Endereco = 'POR DO SOL',
	Bairro = 'GUAIBA',
	Complemento = '01',
	IDCidade = (SELECT IDCidade FROM CidadeEx WHERE Nome = 'Taquara')
 where IDAssociado = 1;

SELECT * FROM AssociadoEX
SELECT * FROM CidadeEX

DELETE FROM AssociadoEx
WHERE IDCidade = (SELECT IDCidade FROM CidadeEx WHERE Nome = 'Campinas');
DELETE FROM CidadeEx
WHERE Nome = 'Campinas' and UF = 'SP';

DELETE FROM AssociadoEx
WHERE IDCidade = (SELECT IDCidade FROM CidadeEx WHERE Nome = 'Taquara');
DELETE FROM CidadeEx
WHERE Nome = 'Taquara' and UF = 'RS';
