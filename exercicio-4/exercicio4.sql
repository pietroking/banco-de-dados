CREATE TABLE alunoAula1(
	idAluno INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nome VARCHAR(50) NOT NULL,
	dataNascimento TIMESTAMP NOT NULL,
	cidade VARCHAR(30) NOT NULL,
	cpf NUMERIC(11,0) NOT NULL UNIQUE,
	matricula INTEGER NOT NULL,
	cursoMatriculado INTEGER NOT NULL
	--idCurso INTEGER
);

CREATE TABLE cursoAula1(
	idCurso INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nome VARCHAR(30) NOT NULL,
	dataCurso TIMESTAMP NOT NULL,
	situacao CHAR(1) DEFAULT NULL,
	preRequisitos VARCHAR(30),
	localCurso VARCHAR(30) NOT NULL,
	idAluno INTEGER
);

CREATE TABLE preRequisitoCurso(
	idPreRequisitoCurso INTEGER NOT NULL PRIMARY KEY,
	idCurso INTEGER NOT NULL,
	idCursoPreRequisito INTEGER NOT NULL
);

ALTER TABLE cursoAula1 ADD COLUMN valor NUMERIC(6,2) NOT NULL DEFAULT 0;

--alter table alunoAula1
  --add constraint pk_aluno primary key (idAluno);
alter table cursoAula1
  add constraint fk_aluno_curso foreign key (idAluno)
  references alunoAula1 (idAluno);
--alter table cursoAula1
  --add constraint pk_curso primary key (idCurso);
--alter table cursoAula1
  --add constraint fk_curso_preRequisito foreign key (preRequisitos)
  --references preRequisitoCurso (idCursoPreRequisito);
--alter table preRequisitoCurso
  --add constraint fk_preRequisito_curso foreign key (idCurso)
  --references cursoAula1 (idCurso);
  
  SELECT * FROM alunoAula1
  insert into alunoAula1 (nome, dataNascimento, cidade, cpf, matricula, cursoMatriculado)
   values ('PIETRO', '10-05-1995', 'PORTO ALEGRE', '12345678910', '0000000', 1);
   insert into alunoAula1 (nome, dataNascimento, cidade, cpf, matricula, cursoMatriculado)
   values ('PIETRO', '10-05-1995', 'PORTO ALEGRE', 12345678911, 00000000, 1);
   insert into alunoAula1 (nome, dataNascimento, cidade, cpf, matricula, cursoMatriculado)
   values ('PIETRO', '10-05-1995', 'PORTO ALEGRE', 12345678912, 00000000, 1);
   insert into alunoAula1 (nome, dataNascimento, cidade, cpf, matricula, cursoMatriculado)
   values ('PIETRO', '10-05-1995', 'PORTO ALEGRE', 12345678913, 00000000, 1);
   insert into alunoAula1 (nome, dataNascimento, cidade, cpf, matricula, cursoMatriculado)
   values ('PIETRO', '10-05-1995', 'PORTO ALEGRE', 12345678914, 00000000, 1);
   insert into alunoAula1 (nome, dataNascimento, cidade, cpf, matricula, cursoMatriculado)
   values ('PIETRO', '10-05-1995', 'PORTO ALEGRE', 12345678915, 00000000, 1);
   insert into alunoAula1 (nome, dataNascimento, cidade, cpf, matricula, cursoMatriculado)
   values ('PIETRO', '10-05-1995', 'PORTO ALEGRE', 12345678916, 00000000, 1);
   insert into alunoAula1 (nome, dataNascimento, cidade, cpf, matricula, cursoMatriculado)
   values ('PIETRO', '10-05-1995', 'PORTO ALEGRE', 12345678917, 00000000, 1);
   insert into alunoAula1 (nome, dataNascimento, cidade, cpf, matricula, cursoMatriculado)
   values ('PIETRO', '10-05-1995', 'PORTO ALEGRE', 12345678918, 00000000, 1);
   insert into alunoAula1 (nome, dataNascimento, cidade, cpf, matricula, cursoMatriculado)
   values ('PIETRO', '10-05-1995', 'PORTO ALEGRE', 12345678919, 00000000, 1);
   
   SELECT * FROM cursoAula1
   insert into cursoAula1 (nome, dataCurso, localCurso)
   values ('ECRESCER', '03-08-2021', 'PORTO ALEGRE');
   insert into cursoAula1 (nome, dataCurso, localCurso)
   values ('ECRESCER', '03-08-2021', 'PORTO ALEGRE');
   insert into cursoAula1 (nome, dataCurso, localCurso)
   values ('ECRESCER', '03-08-2021', 'PORTO ALEGRE');
   insert into cursoAula1 (nome, dataCurso, localCurso)
   values ('ECRESCER', '03-08-2021', 'PORTO ALEGRE');
   insert into cursoAula1 (nome, dataCurso, localCurso)
   values ('ECRESCER', '03-08-2021', 'PORTO ALEGRE');
   insert into cursoAula1 (nome, dataCurso, localCurso)
   values ('ECRESCER', '03-08-2021', 'PORTO ALEGRE');
   insert into cursoAula1 (nome, dataCurso, localCurso)
   values ('ECRESCER', '03-08-2021', 'PORTO ALEGRE');
   insert into cursoAula1 (nome, dataCurso, localCurso)
   values ('ECRESCER', '03-08-2021', 'PORTO ALEGRE');
   insert into cursoAula1 (nome, dataCurso, localCurso)
   values ('ECRESCER', '03-08-2021', 'PORTO ALEGRE');
   insert into cursoAula1 (nome, dataCurso, localCurso)
   values ('ECRESCER', '03-08-2021', 'PORTO ALEGRE');
   
   UPDATE cursoAula1
   SET situacao = 'A';
   
   SELECT * FROM cliente
   UPDATE CLIENTE
   SET situacao = 'P'
   WHERE SELECT * FROM CLIENTE WHERE situacao = 'I';
   
   SELECT * FROM associadoEx
   DELETE FROM associadoEx
   WHERE sexo = 'Feminino';
   
   SELECT * FROM cursoAula1
   UPDATE cursoAula1
   SET valor = 1000;
   
   UPDATE cursoAula1
   SET valor = valor * 1.05;
-- A relação é se o aluno está matriculado no curso. O aluno pode se matricular em varios cursos, e o curso pode ter varios alunos