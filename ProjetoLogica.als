module Disciplina

----------------------------------------Assinaturas---------------------------------

one sig Disciplina{
	--alunos : set Aluno,
	--monitores : set Monitor,
	unidades: set Unidade,
	projeto: set Projeto
}

some sig Aluno{
}

sig Monitor{
	atividades : set Atividade
}

sig Unidade{
	atividades : set Atividade,
	aula : one Aula
}

sig Projeto{
	tema : set Tema
}

sig Nome{}

sig Matricula{}

sig Tema{
	aluno: set Aluno
}

sig Aula{
	monitores : set Monitor
}

abstract sig Atividade {}

sig elaboraCorrigeLista extends Atividade {}
/*one sig corrigeLista extends Atividade {}*/
sig realizaAtendimento extends Atividade {}


----------------------------Fatos----------------------------------------
--fact DisciplinaTemQuatroMonitores{
--	all d : Disciplina | verificaQuantidadeMonitores[d]
--}

fact DisciplinaTemDuasUnidades{
	all d : Disciplina | verificaQuantidadeUnidades[d]
}


fact NumeroDeElementos{
	#Monitor = 4
	#Unidade = 2
	#Aula = 2
}

fact Aulas {

-- Cada aula da unidade deve ser dada por dois monitores diferentes
	all a : Aula | #(a.monitores) = 2

-- Garantir que toda aula irá estar em uma unidade
	all u : Unidade | #(u.aula) = 1 
	all a : Aula | one u : Unidade | a in u.aula
}

fact Alunos {

-- Cada aluno deve estar relacionado a disciplina
--	all a : Aluno | one d : Disciplina | a in d.alunos

-- Cada aluno deve ser alocado em um tema
	all a : Aluno | one t: Tema | a in t.aluno
}

fact Temas {

-- Todos os temas precisam estar no projeto
	all t : Tema | one p : Projeto | t in p.tema

-- Cada tema deve ter 5 alunos usando
	all t : Tema | #(t.aluno) = 5
}

fact Atividades {

-- Cada atividade deve estar relacionada a uma unidade 
	all a : Atividade | one u : Unidade | a in u.atividades
}

fact Unidades {

-- Cada unidade precisa ter as 3 atividades
	all u : Unidade | one a : elaboraCorrigeLista | a in u.atividades
	all u : Unidade | one a : realizaAtendimento | a in u.atividades
}

fact Monitores {

-- Os monitores realizam apenas uma atividade por vez
	all m : Monitor, u: Unidade | one a: Atividade | a in (u.atividades) and a in m.atividades
}

fact Disciplina {

-- A disciplina tem um projeto
	all d: Disciplina | one p: Projeto | p in d.projeto

-- Cada projeto deve estar dentro da disciplina
	all p : Projeto | one d : Disciplina | p in d.projeto
}

-- Cada projeto deve ter apenas um tema
/*fact temaNoProjeto{
	all t : Tema | one p: Projeto | t in p.tema
}*/

-------------------------------- Predicados----------------------------------------------------------------
--pred verificaQuantidadeMonitores[d : Disciplina]{
	--#(d.monitores) = 4
--}

pred verificaQuantidadeUnidades[d : Disciplina]{
	#(d.unidades) = 2
} 

-- O outro predicado pode ser a vericacao da quantidade de temas por monitor, que no máximo é 3

-- pred verificaQuantidadeTemas[m : Monitor]{
--	#(m.temas) <= 3
--}
----------------------------Funcoes--------------------------


-- retorna o numero de projetos por monitor
--fun getNumeroTemas[m: Monitor]: set Tema {
--	(Monitor.Tema)
--}

-- retorna o numero de alunos que esta no acompanhamento do monitor
 --fun getNumeroAlunosAcompanhamento[m: Monitor]: set Aluno {
--	(Monitor.Aluno)
--}



----------------------------Asserts---------------------------
/*assert alunoSemNome{
	all a : Aluno | #(a.nome) > 0 
}

assert alunoSemMatricula{
	all a : Aluno | #(a.matricula) > 0 
}*/

assert unidadeSemAtividades{
	all u : Unidade | #(u.atividades) = 3
}

--assert temQuatroMonitores{
--	all d : Disciplina | #(d.monitores) = 4
--}

assert temDuasUnidades{
	all d : Disciplina | #(d.unidades) = 2
}
--------------------Show--------------------------------------------------
pred show[]{}
run show for 10 

