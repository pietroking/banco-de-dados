CREATE TABLE IF NOT EXISTS aluno(
	idAluno INTEGER NOT NULL,
	nome VARCHAR(50) NOT NULL,
	dataNascimento TIMESTAMP NOT NULL,
	cidade VARCHAR(30) NOT NULL,
	cpf INTEGER NOT NULL UNIQUE,
	matricula INTEGER NOT NULL,
	cursoMatriculado VARCHAR(30) NOT NULL,
	idCurso INTEGER
);

CREATE TABLE IF NOT EXISTS curso(
	idCurso INTEGER NOT NULL UNIQUE,
	nome VARCHAR(30) NOT NULL,
	dataCurso TIMESTAMP NOT NULL,
	situacao CHAR(1) DEFAULT 'A' NOT NULL,
	preRequisitos VARCHAR(30) DEFAULT NULL,
	localCurso VARCHAR(30) NOT NULL
);

ALTER TABLE curso ADD COLUMN valor INTEGER NOT NULL;

alter table aluno
  add constraint pk_aluno primary key (idAluno);
alter table aluno
  add constraint fk_aluno_curso foreign key (idCurso)
  references curso (idCurso);
  
-- A relação é se o aluno está matriculado no curso.