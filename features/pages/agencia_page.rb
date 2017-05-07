# encondig: utf-8
class AgenciaPage < SitePrism::Page
    # BUTTONS
    element :tab_agencia_proxima, :xpath, "//*[@id='OpcaoBuscaAgenProxima']/span/span/a"
    element :tab_agencia_bairro, :xpath, "//*[@id='OpcaoBuscaAgenBairro']/span/span/a"
    element :btn_agencia_proxima_buscar, :xpath, "//div[@id='BuscaAgenProximaForm']/ul[3]/li[2]/a"
	  element :btn_agencia_bairro_buscar, :xpath, "//div[@id='BuscaAgenBairro']//a"
    # INPUTS
    element :inp_cep, :id, "refCep"
    element :inp_numero, :id, "refNumero"
    # DROPDOWN
    element :cmb_Endereco, :xpath, "//select[@id='refEndereco']"
    element :cmb_Estado, :xpath, "//*[@id='localizacaoEstado']"
    element :cmb_Cidade, :xpath, "//*[@id='localizacaoCidade']"
    element :cmb_Bairro, :xpath, "//*[@id='localizacaoBairro']"
    element :txt_endereco, :xpath, "//*[@id='ResBuscaAgen']/div/div"
    # GENERIC ELEMENTS
    element :element_Endereco, :xpath, "//div[@class='agencia']"
    elements :list_agencias_endereco, :xpath, "//div[@id='ResBuscaAgen']/div[@class='agencia']/div[@class='det']"
end
