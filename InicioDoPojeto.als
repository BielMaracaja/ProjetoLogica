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
	/*nome : one Nome,
	matricula : one Matricula*/
}

sig Monitor{
	/*nome : one Nome,*/
	atividades : set Atividade
}

sig Unidade{
	atividades : set Atividade 
}

sig Projeto{
	tema : set Tema
}

sig Nome{}
sig Matricula{}

sig Tema{
	aluno: set Aluno
}

abstract sig Atividade {/*elabora_lista, corrige_lista, realiza_atendimento*/}

sig elaboraCorrigeLista extends Atividade {}
/*one sig corrigeLista extends Atividade {}*/
sig realizaAtendimento extends Atividade {}
sig ministraAula extends Atividade {
	monitor : set Monitor	
}



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
	all u : Unidade | one a : ministraAula | a in u.atividades
}

-- Cada aula precisa ser dada por 2 monitores e não pode ser a mesma pessoa em unidades distintas
fact aulaDadaPorDoisMonitores {
	all m : Monitor | one a : ministraAula | a in m.atividades  
	all m : Monitor | one b : ministraAula | b not in m.atividades 
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

-- Cada tena deve ter 5 alunos usando
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
run show for 20

