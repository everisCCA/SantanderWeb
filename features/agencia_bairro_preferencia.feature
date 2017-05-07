# language: pt
# features/cenario2_agencia_bairro_preferencia.feature

@web @agencia
Funcionalidade: Verificar busca à agências do bairro de preferência

Contexto:
  No site do Santander (www.santander.com.br), dentro do Menu Inferior [Agências], clicar na busca de detalhes de agências no Brasil (link ”clique aqui”) e automatize com BDD os cenários seguintes.

	@agencia_bairro_preferencia
	Cenario: Verificar busca à agência no bairro de preferência do usuário
		Dado que eu esteja na página inicial
		E clico no menu inferior "Agências"
		E clico no link "Clique aqui"
		Quando clico na aba "Busque uma agência no bairro de sua preferência"
		E seleciono uma opção em "Estado"
		E seleciono uma opção em "Cidade"
		E seleciono a opção "Todos" em "Bairro"
		E pressiono o botão "Buscar"
		Então pelo menos uma agência é retornada
