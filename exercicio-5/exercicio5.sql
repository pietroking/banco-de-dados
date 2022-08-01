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

insert into Empregado values (7369 ,'SMITH', 'Atendente', '7902', to_date('1980/12/17','YYYY/MM/DD'),  800, null, 20);
insert into Empregado values (7499 ,'ALLEN', 'Vendedor', '7698', to_date('1981/02/20','YYYY/MM/DD'),  1600, 300, 30);
insert into Empregado values (7521 ,'WARD', 'Vendedor', '7698', to_date('1981/02/22','YYYY/MM/DD'),  1250, 500, 30);
insert into Empregado values (7566 ,'JONES', 'Gerente', '7839', to_date('1981/04/02','YYYY/MM/DD'),  2975, null, 20);
insert into Empregado values (7654 ,'MARTIN', 'Vendedor', '7698', to_date('1981/09/28','YYYY/MM/DD'),  1250, 1400, 30);
insert into Empregado values (7698 ,'BLAKE', 'Gerente', '7839', to_date('1981/05/01','YYYY/MM/DD'),  2850, null, 30);
insert into Empregado values (7782 ,'CLARK', 'Gerente', '7839', to_date('1981/06/09','YYYY/MM/DD'),  2450, null, 10);
insert into Empregado values (7788 ,'SCOTT', 'Analista', '7566', to_date('1982/12/09','YYYY/MM/DD'),  3000, null, 20);
insert into Empregado values (7839 ,'KING', 'Presidente', null, to_date('1981/11/17','YYYY/MM/DD'),  5000, null, null);
insert into Empregado values (7844 ,'TURNER', 'Vendedor', '7698', to_date('1981/09/08','YYYY/MM/DD'),  1500, 0, 30);
insert into Empregado values (7876 ,'ADAMS', 'Atendente', '7788', to_date('1983/01/12','YYYY/MM/DD'),  1100, null, 20);
insert into Empregado values (7900 ,'JAMES', 'Atendente', '7698', to_date('1981/12/03','YYYY/MM/DD'),  950, null, 30);
insert into Empregado values (7902 ,'FORD', 'Analista', '7566', to_date('1981/12/03','YYYY/MM/DD'),  3000, null, 20);
insert into Empregado values (7934 ,'MILLER', 'Atendente', '7782', to_date('1982/01/23','YYYY/MM/DD'),  1300, null, 10);
insert into Empregado values (7940 ,'ANDREW', 'Atendente', '7782', to_date('1988/01/20','YYYY/MM/DD'),  1150, null, null);

create table Departamento (
 IDDepartamento   int not null
,NomeDepartamento varchar(30)
,Localizacao      varchar(25)
);

insert into Departamento values (10,'Contabilidade', 'SAO PAULO');
insert into Departamento values (20,'Pesquisa', 'SAO LEOPOLDO');
insert into Departamento values (30,'Vendas', 'SAO PAULO');
insert into Departamento values (40,'Operações', 'RECIFE');
insert into Departamento values (1, 'Presidência', 'RIBEIRAO PRETO');
insert into Departamento values (60, 'Tecnologia', 'PORTO ALEGRE');

---------
ALTER TABLE Departamento ADD  CONSTRAINT PK_departamento 
  PRIMARY KEY  
  (IDDepartamento);

ALTER TABLE Empregado ADD  CONSTRAINT PK_Empregado
  PRIMARY KEY  
  (IDEmpregado);

ALTER TABLE Empregado ADD CONSTRAINT FK_Empregado_Departamento
  FOREIGN KEY (IDDepartamento) REFERENCES Departamento (IDDepartamento);

CREATE INDEX IX_Empregado_Departamento ON Empregado (IDDepartamento);

SELECT * FROM EMPREGADO
-----------------------------------------------------------------------------------------
SELECT IDEmpregado AS IDEmpregado, NomeEmpregado, DataAdmissao
FROM Empregado
ORDER BY DataAdmissao ASC;

SELECT NOMEEMPREGADO AS NomeEmpregado, Salario, Comissao
FROM Empregado
WHERE Comissao IS NULL
ORDER BY Salario ASC;

SELECT IDEMPREGADO AS IDEmpregado, 
	   NomeEmpregado AS Nome, 
	   (Salario*13) as SalarioAnual, 
	   (Comissao*12) as ComissaoAnual, 
	   ((Salario*13) + (Comissao*12)) as RendaAnual
FROM Empregado
ORDER BY Nome;

SELECT IDEmpregado, 
	   NomeEmpregado,
	   Cargo,
	   (Salario*13) as SalarioAnual
FROM Empregado
WHERE (Cargo = 'Atendente') or ((Salario*13) <=18500)
ORDER BY NomeEmpregado;

SELECT NomeEmpregado,
	   Cargo
FROM Empregado
WHERE (Cargo = 'Atendente') or (IDGerente = 7698)
ORDER BY NomeEmpregado ASC;

SELECT IDDepartamento,
	   NomeDepartamento,
	   Localizacao
FROM Departamento
WHERE Localizacao like 'SAO%'
ORDER BY NomeDepartamento ASC;

SELECT * FROM CidadeEX
WHERE IDCidade between 4 and 9;

SELECT * FROM Departamento
WHERE not exists (SELECT IDDepartamento FROM Empregado WHERE Departamento.IDDepartamento = Empregado.IDDepartamento)
ORDER BY IDDepartamento ASC;

SELECT NomeEmpregado,
	   Cargo
FROM Empregado
WHERE IDDepartamento is null
ORDER BY NomeEmpregado ASC;

SELECT NomeEmpregado
FROM Empregado
WHERE IDGerente in (7566, 7698, 7782)
ORDER BY NomeEmpregado ASC;
