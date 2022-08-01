/*
  Projeto Crescer - Treinamento de banco de dados 
  ---
  Laboratório 2: Comandos DML, Insert's.
*/

insert into CidadeEX (IDCidade, Nome, UF)
   values (1, 'Sao Leopoldo', 'RS');
insert into CidadeEX (IDCidade, Nome, UF)
   values (2, 'Porto Alegre', 'RS');
insert into CidadeEX (IDCidade, Nome, UF)
   values (3, 'Parobe', 'RS');
insert into CidadeEX (IDCidade, Nome, UF)
   values (4, 'Taquara', 'RS');
insert into CidadeEX (IDCidade, Nome, UF)
   values (105, 'São Paulo', 'SP');
insert into CidadeEX (IDCidade, Nome, UF)
   values (106, 'Guarulhos', 'SP');
insert into CidadeEX (IDCidade, Nome, UF)
   values (27, 'Rio de Janeiro', 'RJ');
insert into CidadeEX (IDCidade, Nome, UF)
   values (108, 'Brasilia', 'DF');
insert into CidadeEX (IDCidade, Nome, UF)
   values (109, 'Belo Horizonte', 'MG');
insert into CidadeEX (IDCidade, Nome, UF)
   values (110, 'Uberlândia', 'MG');
insert into CidadeEX (IDCidade, Nome, UF)
   values (5, 'CidadeEX de Alagoas', 'AL');
insert into CidadeEX (IDCidade, Nome, UF)
   values (6, 'Maceio', 'AL');
insert into CidadeEX (IDCidade, Nome, UF)
   values (7, 'Itu', 'SP');
insert into CidadeEX (IDCidade, Nome, UF)
   values (8, 'Campinas', 'SP');
insert into CidadeEX (IDCidade, Nome, UF)
   values (9, 'Guaratingueta', 'SP');
insert into CidadeEX (IDCidade, Nome, UF)
   values (10, 'Santa Barbara', 'MG');
insert into CidadeEX (IDCidade, Nome, UF)
   values (11, 'Campos dos Goitacases', 'RJ');
insert into CidadeEX (IDCidade, Nome, UF)
   values (12, 'Sao Gabriel', 'RS');
insert into CidadeEX (IDCidade, Nome, UF)
   values (13, 'Brasopolis', 'MG');
insert into CidadeEX (IDCidade, Nome, UF)
   values (14, 'Cristina', 'MG');
insert into CidadeEX (IDCidade, Nome, UF)
   values (15, 'Umbuzeiro', 'PB');
insert into CidadeEX (IDCidade, Nome, UF)
   values (16, 'Vicosa', 'MG');
insert into CidadeEX (IDCidade, Nome, UF)
   values (17, 'Macae', 'RJ');
insert into CidadeEX (IDCidade, Nome, UF)
   values (18, 'Sao Luis', 'MA');
insert into CidadeEX (IDCidade, Nome, UF)
   values (19, 'Cuiaba', 'MT');
insert into CidadeEX (IDCidade, Nome, UF)
   values (20, 'Sao Borja', 'RS');
insert into CidadeEX (IDCidade, Nome, UF)
   values (21, 'Natal', 'RN');
insert into CidadeEX (IDCidade, Nome, UF)
   values (22, 'Diamantina', 'MG');
insert into CidadeEX (IDCidade, Nome, UF)
   values (23, 'Campo Grande', 'MS');
insert into CidadeEX (IDCidade, Nome, UF)
   values (24, 'Fortaleza', 'CE');
insert into CidadeEX (IDCidade, Nome, UF)
   values (25, 'Bage', 'RS');
insert into CidadeEX (IDCidade, Nome, UF)
   values (26, 'Bento Goncalves', 'RS');
insert into CidadeEX (IDCidade, Nome, UF)
   values (28, 'Pinheiro', 'MA');
insert into CidadeEX (IDCidade, Nome, UF)
   values (29, 'Salvador', 'BA');
insert into CidadeEX (IDCidade, Nome, UF)
   values (30, 'Garanhuns', 'PE');
Insert into CidadeEX (IDCidade, Nome, UF)
   values (31, 'São Paulo', 'SP');    
Insert into CidadeEX (IDCidade, Nome, UF)
   values (32, 'Guarulhos', 'SP');    
Insert into CidadeEX (IDCidade, Nome, UF)
   values (33, 'Rio de Janeiro', 'RJ');    
Insert into CidadeEX (IDCidade, Nome, UF)
   values (34, 'Brasilia', 'DF');    
Insert into CidadeEX (IDCidade, Nome, UF)
   values (35, 'Belo Horizonte', 'MG');        
Insert into CidadeEX (IDCidade, Nome, UF)
   values  (36, 'Uberlândia', 'MG');      
Insert into CidadeEX (IDCidade, Nome, UF)
   values  (37, 'Santana do Livramento', 'RS');
Insert into CidadeEX (IDCidade, Nome, UF)
   values  (38, 'Santa Maria', 'RS');
Insert into CidadeEX (IDCidade, Nome, UF)
   values  (39, 'Santa Rosa', 'RS');
Insert into CidadeEX (IDCidade, Nome, UF)
   values  (40, 'São Francisco de Paula', 'RS');    

-- ASSOCIADOS...
insert into AssociadoEX 
      (IDAssociado, 
       Nome, 
       DataNascimento, 
       Sexo)
  values 
      (1, 
       'Ana Paula Padrao', 
       to_date('10/05/1980','DD/MM/YYYY'), 
       'F' );
--
insert into AssociadoEX 
      (IDAssociado, 
       Nome, 
       DataNascimento, 
       Sexo)
  values  
      (2, 
       'Joao Soares', 
       to_date('20/02/1980','DD/MM/YYYY'), 
       'M' );
	   
	   insert into AssociadoEX 
      (IDAssociado, 
       Nome, 
       DataNascimento, 
       Sexo,
	  IDCidade)
  values  
      (3, 
       'Joao Soares', 
       to_date('20/02/1980','DD/MM/YYYY'), 
       'M',
	  8);