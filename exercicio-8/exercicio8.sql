SELECT idempregado,
	   nomeempregado,
	   EXTRACT(YEAR FROM (AGE('01/06/2021', DATAADMISSAO))) AS "QTD ANOS",
    EXTRACT(YEAR FROM (AGE('01/06/2021', DATAADMISSAO)))*12 + 
    DATE_PART('MONTH',(AGE('01/06/2021', DATAADMISSAO))) AS "QTD MESES", 
    ('01/06/2021' - DATAADMISSAO) AS "QTD DIAS"
--WHERE EXTRACT(YEAR FROM AGE('01/06/2021',dataadmissao)) = 39
FROM EMPREGADO

SELECT dataadmissao
WHERE EXTRACT(YEAR FROM(dataadmissao = '1981', 'YYYY'))
FROM EMPREGADO;

SELECT max(cargo)
FROM EMPREGADO

--SELECT * FROM CIDADE
SELECT UF,
		count(1) as total
FROM CIDADE
Group By UF
ORDER BY total DESC;

--SELECT * FROM DEPARTAMENTO

SELECT * FROM EMPREGADO
WHERE iddepartamento = 69

insert into DEPARTAMENTO values (69,'Inovação', 'SAO LEOPOLDO');
UPDATE EMPREGADO
   SET iddepartamento = 69
   WHERE (EXTRACT(MONTH FROM dataadmissao) = 12) AND (Cargo <> 'Atendente');