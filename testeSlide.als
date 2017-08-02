module banco
sig Banco{
	contas: set Conta
}

sig Conta{}
sig ContaCorrente extends Conta{}
sig ContaPoupanca extends Conta{}

pred show[]{}

run show
