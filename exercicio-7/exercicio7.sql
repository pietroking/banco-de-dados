SELECT TIMESTAMP '01-oct-2018 15:16:01';
SELECT to_char(CURRENT_TIMESTAMP, 'DD-mon-YYYY HH24:MI:SS') as Data;

SELECT * FROM EMPREGADO

SELECT substr (LOWER(nomeempregado), 1, 4) nome, e.*
FROM EMPREGADO e;

SELECT
		CONCAT (nomeempregado,' ', cargo) as NomeCargo1,
		concat_ws(' ', nomeempregado, cargo) as NomeCargo2
FROM EMPREGADO;

SELECT
		CONCAT (nomeempregado, cargo) as NomeCargo1,
		nomeempregado || cargo as NomeCargo2
FROM EMPREGADO;

SELECT (dataadmissao + interval '8 hours')
FROM EMPREGADO;

SELECT to_char(dataadmissao + '8 hours'::INTERVAL, 'DD/MM/YYYY HH24:MI:SS')
FROM EMPREGADO;
