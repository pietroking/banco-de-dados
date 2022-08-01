create table CIDADE
(
  idcidade INTEGER not null,
  nome     VARCHAR(30 ) not null,
  uf       VARCHAR(2 ) not null
)
;
alter table CIDADE
  add constraint PK_CIDADE primary key (IDCIDADE);

create table CLIENTE
(
  idcliente   INTEGER not null,
  nome        VARCHAR(50 ) not null,
  razaosocial VARCHAR(50 ) not null,
  endereco    VARCHAR(35 ),
  bairro      VARCHAR(30 ),
  idcidade    INTEGER,
  cep         DECIMAL(8),
  situacao    CHAR(1 ) default 'A' not null
)
;
create index IDX_CLIENTE_CIDADE on CLIENTE (IDCIDADE);
create unique index IDX_CLIENTE_ENDERECO on CLIENTE (ENDERECO, IDCLIENTE);
create unique index IDX_CLIENTE_RAZAOSOCIAL on CLIENTE (RAZAOSOCIAL, ENDERECO, IDCLIENTE);
alter table CLIENTE
  add constraint PK_CLIENTE primary key (IDCLIENTE);
alter table CLIENTE
  add constraint FK_CLIENTE_CIDADE foreign key (IDCIDADE)
  references CIDADE (IDCIDADE);
alter table CLIENTE
  add constraint CC_CLIENTE_SITUACAO
  check ((Situacao='I' OR Situacao='A'));

create table MATERIAL
(
  idmaterial  INTEGER not null,
  descricao   VARCHAR(50 ) not null,
  pesoliquido DECIMAL(15,5) not null,
  precocusto  DECIMAL(12,2) not null
)
;
alter table MATERIAL
  add constraint PK_MATERIAL primary key (IDMATERIAL);

create table PEDIDO
(
  idpedido    INTEGER not null,
  idcliente   INTEGER not null,
  datapedido  DATE default current_date not null,
  dataentrega DATE,
  valorpedido DECIMAL(12,2) default 0 not null,
  situacao    CHAR(1 ) default 'A' not null
)
;
alter table PEDIDO
  add constraint PK_PEDIDO primary key (IDPEDIDO);
alter table PEDIDO
  add constraint FK_PEDIDO_CLIENTE foreign key (IDCLIENTE)
  references CLIENTE (IDCLIENTE);
alter table PEDIDO
  add constraint CC_PEDIDO_DATAENTREGA
  check ((DataEntrega>=DataPedido));
alter table PEDIDO
  add constraint CC_PEDIDO_SITUACAO
  check ((Situacao='I' OR Situacao='Q' OR Situacao='C' OR Situacao='A'));

create table PRODUTO
(
  idproduto    INTEGER not null,
  nome         VARCHAR(50 ) not null,
  datacadastro DATE default current_date not null,
  precocusto   DECIMAL(12,2) not null,
  precovenda   DECIMAL(12,2),
  situacao     CHAR(1 ) not null
)
;
create index IDX_PRODUTO_NOME on PRODUTO (NOME);
create index IDX_PRODUTO_PRECO on PRODUTO (PRECOCUSTO, PRECOVENDA);
alter table PRODUTO
  add constraint PK_PRODUTO primary key (IDPRODUTO);

create table PEDIDOITEM
(
  idpedidoitem  INTEGER not null,
  idpedido      INTEGER not null,
  quantidade    DECIMAL(12,3) not null,
  precounitario DECIMAL(12,2) not null,
  situacao      CHAR(1 ) default 'A' not null,
  idproduto     INTEGER
)
;
create index IX_PEDIDOITEM_PEDIDO on PEDIDOITEM (IDPEDIDO);
create index IX_PEDIDOITEM_PRODUTO on PEDIDOITEM (IDPRODUTO);
alter table PEDIDOITEM
  add constraint PK_PEDIDOITEM primary key (IDPEDIDOITEM);
alter table PEDIDOITEM
  add constraint FK_PEDIDOITEM_PEDIDO foreign key (IDPEDIDO)
  references PEDIDO (IDPEDIDO);
alter table PEDIDOITEM
  add constraint FK_PEDIDOITEM_PRODUTO foreign key (IDPRODUTO)
  references PRODUTO (IDPRODUTO);
alter table PEDIDOITEM
  add constraint CC_PEDIDOITEM_QUANTIDADE
  check ((Quantidade>(0)));
alter table PEDIDOITEM
  add constraint CC_PEDIDOITEM_SITUACAO
  check ((Situacao='I' OR Situacao='Q' OR Situacao='C' OR Situacao='A'));

create table PRODUTOMATERIAL
(
  idprodutomaterial INTEGER not null,
  idproduto         INTEGER not null,
  idmaterial        INTEGER not null,
  quantidade        DECIMAL(12,3)
)
;
alter table PRODUTOMATERIAL
  add constraint PK_PRODUTOMATERIAL primary key (IDPRODUTOMATERIAL);
alter table PRODUTOMATERIAL
  add constraint FK_PRODUTOMATERIAL_MATERIAL foreign key (IDMATERIAL)
  references MATERIAL (IDMATERIAL);
alter table PRODUTOMATERIAL
  add constraint FK_PRODUTOMATERIAL_PRODUTO foreign key (IDPRODUTO)
  references PRODUTO (IDPRODUTO);


  
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

create table Empregado (
 IDEmpregado    int not null
,NomeEmpregado  varchar(30) not null
,Cargo          varchar(15) not null
,IDGerente      int null
,DataAdmissao   date not null
,Salario        decimal(7,2) not null
,Comissao       decimal(7,2)
,IDDepartamento int
);


create table Departamento (
 IDDepartamento   int not null
,NomeDepartamento varchar(30)
,Localizacao      varchar(25)
);


ALTER TABLE Departamento ADD  CONSTRAINT PK_departamento 
  PRIMARY KEY  
  (IDDepartamento);

ALTER TABLE Empregado ADD  CONSTRAINT PK_Empregado
  PRIMARY KEY  
  (IDEmpregado);

ALTER TABLE Empregado ADD CONSTRAINT FK_Empregado_Departamento
  FOREIGN KEY (IDDepartamento) REFERENCES Departamento (IDDepartamento);

CREATE INDEX IX_Empregado_Departamento ON Empregado (IDDepartamento);

----------------------------------------------------------------------------------------

SELECT * FROM PEDIDO

SELECT idpedido,
	   idcliente,
	   datapedido,
	   valorpedido,
	   situacao
FROM PEDIDO
WHERE (((situacao = 'A') and (idcliente = 11518)) or (valorpedido > 9000))
ORDER BY valorpedido ASC;

SELECT * FROM MATERIAL
WHERE ((pesoliquido > 4) and (precocusto < 0.30));

SELECT nome, uf FROM CIDADE
WHERE UF = 'RS'
ORDER BY nome ASC;

SELECT * FROM PEDIDOITEM
WHERE idpedido = (SELECT idpedido FROM PEDIDO WHERE valorpedido = 28299.76);

SELECT * FROM CLIENTE
WHERE situacao = 'A' and cep is null;

SELECT idpedido,
	   (quantidade * precounitario) as VALORTOTAL,
	   idproduto
	   FROM PEDIDOITEM
WHERE idpedido = (SELECT idpedido FROM PEDIDO WHERE idpedido = 168)
ORDER BY VALORTOTAL DESC;

SELECT * FROM MATERIAL
WHERE pesoliquido BETWEEN 0.5 AND 0.6;

SELECT * FROM PEDIDO
WHERE EXISTS ()