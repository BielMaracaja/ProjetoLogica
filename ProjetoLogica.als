module Disciplina

-------------------------------------------Assinaturas-----------------------------------------

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
sig realizaAtendimento extends Atividade {}


-------------------------------------------------Fatos-----------------------------------------

-- Existem 1 disciplina, 4 monitores, 2 unidades e 1 projeto
fact NumeroDeElementos{
	
	#Monitor = 4
	all d : Disciplina | verificaQuantidadesUnidade[d]
	all u : Unidade | verificaQuantidadesAula[u]
	all d : Disciplina | verificaQuantidadesProjeto[d]
}

fact Aulas {

-- Cada aula da unidade deve ser dada por dois monitores diferentes
	all a : Aula | #getMonitoresAula[a] = 2

-- Garantir que toda aula irá estar em uma unidade
	all u : Unidade | #getAulaPorUnidade[u] = 1 
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
	all t : Tema | #getAlunosTema[t] = 5

-- Cada tema deve estar relacionado a um monitor
	all t : Tema | one m : Monitor | t in m.temas
}

fact Atividades {

-- Cada atividade deve estar relacionada a uma unidade 
	all a : Atividade | one u : Unidade | a in u.atividades
}

fact Unidades {

-- Cada unidade precisa ter as 2 atividades
	all u : Unidade | one a : elaboraCorrigeLista | a in u.atividades
	all u : Unidade | one a : realizaAtendimento | a in u.atividades
}

fact Monitores {

-- Os monitores realizam apenas uma atividade por vez
	all m : Monitor, u: Unidade | one a: Atividade | a in (u.atividades) and a in m.atividades

-- Todo monitor deve ter pelo menos um tema
	all m : Monitor | some t : Tema | t in m.temas

-- Todo monitor deve ter no maximo 3 temas
	all m : Monitor | verificaQuantidadeTemas[m]

-- Todo monitor deve estar relacionado a aula
	all m : Monitor | one a : Aula | m in a.monitores

-- Toda lista deve estar sendo elaborada e corrigida por um monitor
	all l : elaboraCorrigeLista | one m: Monitor | l in m.atividades

-- Um monitor pode acompanhar no máximo 3 alunos no projeto
	all m : Monitor | #getAlunosDoMonitor[m] < 4
}

fact Disciplina {

-- A disciplina tem um projeto
	all d: Disciplina | one p: Projeto | p in d.projeto

-- Cada projeto deve estar dentro da disciplina
	all p : Projeto | one d : Disciplina | p in d.projeto
}

-------------------------------------------Predicados-----------------------------------------

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

-------------------------------------------Funções-----------------------------------------

fun getAlunosTema[t:Tema]: set Aluno {
	(t.aluno)
}

fun getMonitoresAula[a:Aula]: set Monitor {
	(a.monitores)
}

fun getAulaPorUnidade[u:Unidade]: set Aula {
	(u.aula)
}

fun getAlunosDoMonitor[m:Monitor]: set Aluno {
	(m.alunos)
}

fun getNumeroTemas[m: Monitor]: set Tema {
	(m.temas)
}

-------------------------------------------Asserts-----------------------------------------

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
-------------------------------------------Checks-----------------------------------------

--check unidadeTemDuasAtividades for 20

--check disciplinaTemDuasUnidades for 20

--check disciplinaTemUmProjeto for 20

--check monitorAcompanhaAteTresAlunos for 20

-------------------------------------------Show-----------------------------------------

-- Mínimo de Alunos: 20 (um tema para cada monitor)
-- Máximo de Alunos: 60 (três temas para cada monitor)

pred show[]{ }
run show for 20 but exactly 20 Aluno

