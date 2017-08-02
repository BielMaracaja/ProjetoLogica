abstract sig Disciplina{
	// Cada Discilpina tem um (n alunos), (4 monitores), (2 unidades), (Projeto);
	aluno: some Aluno,
	monitores: #Monitor = 4,
	unidade: #Unidade = 2,
}

sig Aluno{
}

sig Monitor{
}

//Cada unidade tem um tempo;
sig Unidade{
}
