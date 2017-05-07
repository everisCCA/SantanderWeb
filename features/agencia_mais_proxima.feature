# language: pt
# features/cenario1_agencia_mais_proxima.feature

@web @agencia
Funcionalidade: Verificar busca à agências mais próximas

Contexto:
  No site do Santander (www.santander.com.br), dentro do Menu Inferior [Agências], clicar na busca de detalhes de agências no Brasil (link ”clique aqui”) e automatize com BDD os cenários seguintes.

	@agencia_mais_proxima
	Cenario: Verificar busca às agências mais próximas
		Dado que eu esteja na página inicial
		E clico no menu inferior "Agências"
		E clico no link "Clique aqui"
		Quando clico na aba "Busque a agência mais próxima de você"
		E preencho o campo CEP com "Barueri"
		E preencho o campo número
		E pressiono o botão "Buscar"
		E seleciono o primeiro endereço na dropdown
		Então pelo menos uma agência é retornada
		E o endereço "AL ARAGUAIA 631 E, ALPHAVILLE - BARUERI - SP" é mostrado no retorno da busca
