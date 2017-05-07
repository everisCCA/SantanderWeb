# encondig: utf-8
class HomePage < SitePrism::Page
    # LINKS
    element :menu_inf_agencias, :xpath, "//footer//a[.=' Agências ']"
    element :click_aqui, :xpath, "//a[.='Clique aqui ']"
    # BUTTONS
    # INPUTS
    element :inp_cep, :xpath, "//*[@id='refCep']"
    element :inp_numero, :xpath, "//*[@id='refNumero']"
    # DROPDOWN
end
