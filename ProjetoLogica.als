module Disciplina

----------------------------------------Assinaturas---------------------------------

-- Uma disciplina tem duas unidades (provas) e um projeto
one sig Disciplina{
	unidades: set Unidade,
	projeto: set Projeto
}

some sig Aluno{}

sig Monitor{
	atividades : set Atividade,
	temas: set Tema,
	alunos: set Aluno
}

sig Unidade{
	atividades : set Atividade,
	aula : one Aula
}

sig Projeto{
	tema : set Tema
}

sig Tema{
	aluno: set Aluno
}

sig Aula{
	monitores : set Monitor
}

abstract sig Atividade {}

sig elaboraCorrigeLista extends Atividade {}
/*one sig corrigeLista extends Atividade {}*/
sig realizaAtendimento extends Atividade {
--	alunos : set Aluno
}


----------------------------Fatos----------------------------------------
fact NumeroDeElementos{
	-- Existem 1 disciplina, 4 monitores, 2 unidades e 1 projeto
	#Monitor = 4
	all d : Disciplina | verificaQuantidadesUnidade[d]
	all u : Unidade | verificaQuantidadesAula[u]
	all d : Disciplina | verificaQuantidadesProjeto[d]
}

fact Aulas {

-- Cada aula da unidade deve ser dada por dois monitores diferentes
	all a : Aula | #(a.monitores) = 2

-- Garantir que toda aula irá estar em uma unidade
	all u : Unidade | #(u.aula) = 1 
	all a : Aula | one u : Unidade | a in u.aula
}

fact Alunos {

-- Cada aluno deve ser alocado em um tema
	all a : Aluno | one t: Tema | a in t.aluno
}

fact Temas {

-- Todos os temas precisam estar no projeto
	all t : Tema | one p : Projeto | t in p.tema

-- Cada tema deve ter 5 alunos usando
	all t : Tema | #(t.aluno) = 5

-- Cada tema deve estar relacionado a um monitor
	all t : Tema | one m : Monitor | t in m.temas
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

-- Todo monitor deve ter pelo menos um tema
	all m : Monitor | some t : Tema | t in m.temas

-- Todo monitor deve ter no maximo 3 temas
	all m : Monitor | verificaQuantidadeTemas[m] --#(m.temas) < 4

-- Todo monitor deve estar relacionado a aula
	all m : Monitor | one a : Aula | m in a.monitores

-- Toda lista deve estar sendo elaborada e corrigida por um monitor
	all l : elaboraCorrigeLista | one m: Monitor | l in m.atividades

-- Um monitor pode acompanhar no máximo 3 alunos no projeto
	all m : Monitor | #(m.alunos) < 4

 -- all m: Monitor, t: Tema | verificaQuantidadeDeAlunosPorMonitor[m, t]

--  all m: Monitor | some t: Tema, a: Aluno | a in m.alunos => a in t.aluno

--	all a : Aluno | one m : Monitor, t : Tema | t in m.temas and a in t.aluno

--	all m : Monitor, t : Tema | some a : Aluno | a in m.alunos => a in t.aluno

--	all m : Monitor | one a : Aluno,  t1 : Tema, t2 : Tema | a in t1.aluno and t1 in m.temas => a not in t2.aluno and t2 not in m.temas

--	all m : Monitor, a : Aluno | one t : Tema | t in m.temas => a in t.aluno

-- all t : Tema | some a : Aluno, m : Monitor | a in m.alunos => (t in m.temas and a in t.aluno) 

--	all a : Aluno | one m : Monitor, t : Tema | a in m.alunos => a in t.aluno

--all a1 : Aluno, a2 : Aluno | one m : Monitor, t : Tema | a1 in m.alunos and a2 in m.alunos => a1 in t.aluno and a2 in t.aluno
}

fact Disciplina {

-- A disciplina tem um projeto
	all d: Disciplina | one p: Projeto | p in d.projeto

-- Cada projeto deve estar dentro da disciplina
	all p : Projeto | one d : Disciplina | p in d.projeto
}

-------------------------------- Predicados----------------------------------------------------------------

pred verificaQuantidadesProjeto[d : Disciplina]{
	#(d.projeto) = 1
}

pred verificaQuantidadesUnidade[d : Disciplina]{
	#(d.unidades) = 2
} 

pred verificaQuantidadesAula[u : Unidade]{
	#(u.aula) = 1
}

pred verificaQuantidadeTemas[m : Monitor]{
	#(m.temas) < 4
}

----------------------------Funcoes--------------------------

--fun atividadesDaUnidade[r: realizaAtendimento]: set Conta {
--b.contas
--} 

-- retorna o numero de projetos por monitor
fun getNumeroTemas[m: Monitor]: set Tema {
	(m.temas)
}

-- retorna o numero de alunos que esta no acompanhamento do monitor
 fun getNumeroAlunosAcompanhamento[m: Monitor]: set Aluno {
	(m.alunos)
}

--fun alunosDeMonitor [m: Monitor, t: Tema]  : set Aluno {
--	m.alunos & t.aluno
--}

----------------------------Asserts---------------------------

assert unidadeTemDuasAtividades{
	all u : Unidade | #(u.atividades) = 2
}

assert disciplinaTemDuasUnidades{
	all d : Disciplina | #(d.unidades) = 2
}

assert disciplinaTemUmProjeto{
	all d : Disciplina | #(d.projeto) = 1
}

assert monitorAcompanhaAteTresAlunos{
	all m : Monitor | #(m.alunos) < 4
}

----------------------------Checks---------------------------

--check unidadeTemDuasAtividades for 20

--check disciplinaTemDuasUnidades for 20

--check disciplinaTemUmProjeto for 20

--check monitorAcompanhaAteTresAlunos for 20

--------------------Show--------------------------------------------------

pred show[]{ }
run show for 20 but exactly 20 Aluno

