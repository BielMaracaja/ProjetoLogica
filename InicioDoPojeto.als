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

abstract sig Disciplina{
	aluno : some Aluno
	/*monitor : #Monitor = 4
	unidade : #Unidade = 2
	projeto : some Projeto*/
}

some sig Aluno{
	nome : one Nome,
	matricula : some Matricula
}

assert alunoSemNome{
	all a : Aluno | #(a.nome) > 0 
}

assert alunoSemMatricula{
	all a : Aluno | #(a.matricula) > 0 
}

sig Monitor{
	nome : one Nome,
	atividade : one Atividade
}

sig Unidade{
	aula : one Aula
}

assert unidadeSemAula{
	all u : Unidade | #(u.aula) > 0
}

sig Projeto{
	tema : one Tema
}

sig Nome{}
sig Matricula{}
sig Atividade{}
sig Aula{}
sig Tema{}


pred show[]{}
run show
