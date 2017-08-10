/*
Tema 9: Monitoria de Lógica
Em um determinado período, a disciplina de Lógica Matemática dispõe de quatro monitores que são responsáveis por 
algumas atividades distribuídas entre as três unidades da disciplina. 
Entre as atividades realizadas em todos os estágios temos: elaborar e corrigir listas de exercício e realizar atendimento 
presencial com os alunos. Estas atividades podem ser realizadas por todos os monitores, 
mas um monitor que participou da elaboração de uma lista deve, obrigatoriamente, corrigir a mesma. 
Em cada um dos dois primeiros estágios temos uma aula de exercícios que deve ser ministrada por dois monitores, 
de modo que cada monitor está presente em apenas uma delas. No terceiro estágio todos os monitores devem realizar 
a elaboração de temas para projetos e acompanhar até três grupos de alunos, 
onde cada grupo é formado por 5 alunos. O atendimento a alunos é realizado sob demanda. Dessa forma, os alunos podem 
solicitar encontros presenciais com os monitores e cada monitor pode 
acompanhar até 3 alunos em cada encontro. Os monitores realizam apenas uma atividade por vez.  

Cliente: Gabriela

Integrantes: Raquel Rufino, Pedro Henrique, Victor Emanuel, Mateus Mangueira e Gabriel Maracajá 
*/


// Cada Discilpina tem um (n alunos), (4 monitores), (2 unidades), (Projeto);

module Disciplina

----------------------------------------Assinatura---------------------------------

one sig Disciplina{
	alunos : set Aluno,
	monitores : set Monitor,
	unidades: set Unidade,
	projeto: set Projeto
}

some sig Aluno{
	nome : one Nome,
	matricula : one Matricula
}

sig Monitor{
	nome : one Nome,
	atividade : one Atividade
}

sig Unidade{
	aula : one Aula 
}

sig Projeto{
	aluno: set Aluno,
	tema : one Tema
}

sig Nome{}
sig Matricula{}
sig Tema{}
sig Aula{}

abstract sig Atividade {/*elabora_lista, corrige_lista, realiza_atendimento*/}

one sig elaboraLista extends Atividade {}
one sig corrigeLista extends Atividade {}
one sig realizaAtendimento extends Atividade {}



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

/*fact apenasUmProjeto{
	#Projeto = 1
}*/

/*fact DisciplinaTemUnidades{
	all u : Unidade | one d : Disciplina | u in d.unidades
}*/

-- Cada aluno deve estar relacionado a disciplina
fact alunoMatriculado{
	all a : Aluno | one d : Disciplina | a in d.alunos
}

-- Cada matricula deve estar relacionada a apenas um aluno
fact matriculaDoAluno{
	all m : Matricula | one a : Aluno |m in a.matricula
}

-- Cada nome deve estar relacionada a apenas um aluno ou um monitor
/*fact nomeDaPessoa{
	(all n : Nome | one a : Aluno | n in a.nome) or (all n : Nome | one a : Monitor | n in a.nome)
}*/

-- Cada aula deve estar relacionada a uma unidade
fact aulaDaUnidade{
	all a : Aula | one u : Unidade | a in u.aula
}

-- Cada nome deve estar relacionado a uma pessoa
/*fact nomeNaoOrfao{
	all n : Nome | one a : Aluno or one a: Monitor | n in a.nome
}*/

-- Cada aluno deve ser alocado no projeto
fact projetoNoAluno{
	all a : Aluno | one p: Projeto | a in p.aluno
}

-- Cada nome deve estar em apenas um monitor ou apenas um aluno
fact nomeUsadoApenasEmUmAlunoOuMonitor{
	all a1: Aluno, a2: Aluno - a1, n: Nome | n in a1.nome => n not in a2.nome
	all m1: Monitor, m2: Monitor - m1, n: Nome | n in m1.nome => n not in m2.nome
	all a: Aluno, m: Monitor, n: Nome | n in a.nome => n not in m.nome
}

-- Cada projeto deve ter apenas um tema
fact temaNoProjeto{
	all t : Tema | one p: Projeto | t in p.tema
}

-- Cada projeto deve ter 5 alunos usando
fact cincoAlunosNoProjeto{
	all p : Projeto | #(p.aluno) = 5
}

fact disciplinaTemProjeto{
	all d: Disciplina | one p: Projeto | p in d.projeto
}
-- Cada projeto deve estar dentro da disciplina
/*fact projetoNaDisciplina{
	all p : Projeto | one d : Disciplina | p in d.projeto
}*/
-------------------------------- Predicados----------------------------------------------------------------
pred verificaQuantidadeMonitores[d : Disciplina]{
	#(d.monitores) = 4
}

pred verificaQuantidadeUnidades[d : Disciplina]{
	#(d.unidades) = 2
} 

----------------------------Funcoes--------------------------

----------------------------Asserts---------------------------
assert alunoSemNome{
	all a : Aluno | #(a.nome) > 0 
}

assert alunoSemMatricula{
	all a : Aluno | #(a.matricula) > 0 
}

assert unidadeSemAula{
	all u : Unidade | #(u.aula) > 0
}
--------------------Show--------------------------------------------------
pred show[]{}
run show for 10

