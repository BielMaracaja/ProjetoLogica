module Disciplina

----------------------------------------Assinaturas---------------------------------

one sig Disciplina{
	alunos : set Aluno,
	monitores : set Monitor,
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
fact DisciplinaTemQuatroMonitores{
	all d : Disciplina | verificaQuantidadeMonitores[d]
}

fact DisciplinaTemDuasUnidades{
	all d : Disciplina | verificaQuantidadeUnidades[d]
}

fact NumeroDeMonitores{
	#Monitor = 4
}

fact NumeroDeUnidade{
	#Unidade = 2
}

fact NumeroDeAulas{
	#Aula = 2
}

-- Cada aula da unidade deve ser dada por dois monitores diferentes
fact MonitoresPorAula{
	all a : Aula | #(a.monitores) = 2
} 

-- Garantir que toda aula irá estar em uma unidade
fact AulaPorUnidade{
	all u : Unidade | one a : Aula | a in u.aula
	/*all u1 : Unidade, u2 : Unidade | one a : Aula | a in u1.aula , a not in u2.aula*/
	all u : Unidade | #(u.aula) = 1 
}

-- Cada aluno deve estar relacionado a disciplina
fact alunoMatriculado{
	all a : Aluno | one d : Disciplina | a in d.alunos
}

-- Todos os temas precisam estar no projeto
fact temasNoProjeto{
	all t : Tema | one p : Projeto | t in p.tema
}

-- Cada matricula deve estar relacionada a apenas um aluno
/*fact matriculaDoAluno{
	all m : Matricula | one a : Aluno |m in a.matricula
}*/

-- Cada nome deve estar relacionada a apenas um aluno ou um monitor
/*fact nomeDaPessoa{
	(all n : Nome | one a : Aluno | n in a.nome) or (all n : Nome | one a : Monitor | n in a.nome)
}*/

-- Cada atividade deve estar relacionada a uma unidade 
fact atividadesDaUnidade{
	all a : Atividade | one u : Unidade | a in u.atividades
}

-- Cada nome deve estar relacionado a uma pessoa
/*fact nomeNaoOrfao{
	all n : Nome | one a : Aluno or one a: Monitor | n in a.nome
}*/

-- Cada aluno deve ser alocado em um tema
fact temaNoAluno{
	all a : Aluno | one t: Tema | a in t.aluno
}

-- Cada unidade precisa ter as 3 atividades
fact unidadeTemTresAtividades{
	all u : Unidade | one a : elaboraCorrigeLista | a in u.atividades
	all u : Unidade | one a : realizaAtendimento | a in u.atividades
}

-- Os monitores realizam apenas uma atividade por vez(a monitoria acha que eh assim,)

fact realizamPorVez{
	all m : Monitor, u: Unidade | one a: Atividade | a in (u.atividades) and a in m.atividades
}
-- Cada nome deve estar em apenas um monitor ou apenas um aluno
/*fact nomeUsadoApenasEmUmAlunoOuMonitor{
	all a1: Aluno, a2: Aluno - a1, n: Nome | n in a1.nome => n not in a2.nome
	all m1: Monitor, m2: Monitor - m1, n: Nome | n in m1.nome => n not in m2.nome
	all a: Aluno, m: Monitor, n: Nome | n in a.nome => n not in m.nome
}*/

-- Cada projeto deve ter apenas um tema
/*fact temaNoProjeto{
	all t : Tema | one p: Projeto | t in p.tema
}*/

-- Cada tema deve ter 5 alunos usando
fact cincoAlunosComOTema{
	all t : Tema | #(t.aluno) = 5
}

fact disciplinaTemProjeto{
	all d: Disciplina | one p: Projeto | p in d.projeto
}
-- Cada projeto deve estar dentro da disciplina
fact projetoNaDisciplina{
	all p : Projeto | one d : Disciplina | p in d.projeto
}
-------------------------------- Predicados----------------------------------------------------------------
pred verificaQuantidadeMonitores[d : Disciplina]{
	#(d.monitores) = 4
}

pred verificaQuantidadeUnidades[d : Disciplina]{
	#(d.unidades) = 2
} 

-- O outro predicado pode ser a vericacao da quantidade de temas por monitor, que no máximo é 3

-- pred verificaQuantidadeTemas[m : Monitor]{
--	#(m.temas) <= 3
--}
----------------------------Funcoes--------------------------


-- retorna o numero de projetos por monitor
-- fun getNumeroTemas[m: Monitor]: set Temas {
--	(Monitor.Temas)
--}

-- retorna o numero de alunos que esta no acompanhamento do monitor
-- fun getNumeroAlunosAcompanhamento[m: Monitor]: set Alunos {
--	(Monitor.Alunos)
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

assert temQuatroMonitores{
	all d : Disciplina | #(d.monitores) = 4
}

assert temDuasUnidades{
	all d : Disciplina | #(d.unidades) = 2
}
--------------------Show--------------------------------------------------
pred show[]{}
run show for 10 

