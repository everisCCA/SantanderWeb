#encoding: utf-8
#!/usr/bin/env ruby

Before('@agencia') do
  @home_page = HomePage.new
  @agencia_page = AgenciaPage.new
end

########################################################################################################################
#DADO
########################################################################################################################


########################################################################################################################
#QUANDO
########################################################################################################################

Quando(/^clico na aba "([^"]*)"$/) do |aba|
  $aba = aba
  Utils.windows(page)
  # Muda o foco para a última janela
  page.driver.browser.switch_to.window($window_last)
  # Muda o foco para o iframe principal
  within_frame 0 do
    # Seleciono a aba
    case
      when aba.include?("agência mais próxima")
        @agencia_page.tab_agencia_proxima.click
      when aba.include?("agência no bairro")
        @agencia_page.tab_agencia_bairro.click
    end
  end
end

Quando(/^preencho o campo CEP com "([^"]*)"$/) do |cep|
  # Captura a janela principal e a última aberta
  Utils.windows(page)
  # Muda o foco para a última janela
  page.driver.browser.switch_to.window($window_last)
  # Muda o foco para o iframe principal
  within_frame 0 do
    #preenche o campo
    @agencia_page.inp_cep.set $DATA_ENDERECOS['enderecos'][cep]['CEP']
  end
  # Muda o foco para a janela principal
  # page.driver.browser.switch_to.window($window_main)
end

Quando(/^preencho o campo número$/) do
  # Muda o foco para o iframe principal
  within_frame 0 do
    #preenche o campo
    @agencia_page.inp_numero.set Faker::Number.number(2)
  end
end

Quando(/^seleciono o primeiro endereço na dropdown$/) do
  within_frame 0 do
    # clica na combobox com os endereços e seleciona a primeira opção
    @agencia_page.cmb_Endereco.find(:xpath, 'option[2]').select_option
  end
end

Quando(/^seleciono uma opção em "([^"]*)"$/) do |campo|
  opcao = Faker::Number.number(1)
  within_frame 0 do
    case campo
      when 'Estado'
        resultados = @agencia_page.cmb_Estado.all('option').collect(&:text)
        @rand_estado = Faker::Number.between(2, resultados.length)
        @agencia_page.cmb_Estado.find(:xpath, "option[#{@rand_estado}]").select_option
        sleep 1
      when 'Cidade'
        resultados = @agencia_page.cmb_Cidade.all('option').collect(&:text)
        @rand_cidade = Faker::Number.between(2, resultados.length)
        @agencia_page.cmb_Cidade.find(:xpath, "option[#{@rand_cidade}]").select_option
      else
        raise "Campo #{campo} não encontrado!"
    end
  end
end


Quando(/^seleciono a opção "([^"]*)" em "([^"]*)"$/) do |opcao, campo|
  within_frame 0 do
    @agencia_page.cmb_Bairro.find(:xpath, 'option[2]').select_option
  end
end

Quando(/^pressiono o botão "([^"]*)"$/) do |botao|
  # Muda o foco para o iframe principal
  within_frame 0 do
    case botao
      when 'Buscar'
        # Seleciona o botão de acordo com a aba definida
        case
          when $aba.include?("agência mais próxima")
            @agencia_page.btn_agencia_proxima_buscar.click
          when $aba.include?("agência no bairro")
            @agencia_page.btn_agencia_bairro_buscar.click
        end
    end
  end
end

########################################################################################################################
#ENTAO
########################################################################################################################

Então(/^pelo menos uma agência é retornada$/) do
  within_frame 0 do
    case
      when $aba.include?("agência mais próxima")
        @agencia_page.wait_for_element_Endereco
        expect(@agencia_page).to have_element_Endereco
      when $aba.include?("agência no bairro")
        str_estado = @agencia_page.cmb_Estado.find(:xpath, "option[#{@rand_estado}]").text
        str_cidade = @agencia_page.cmb_Cidade.find(:xpath, "option[#{@rand_cidade}]").text
        @agencia_page.list_agencias_endereco.each { |agencia| expect(agencia.text).to include(str_estado)}
        @agencia_page.list_agencias_endereco.each { |agencia| expect(agencia.text).to include(str_cidade)}
    end
  end
end

Então(/^o endereço "([^"]*)" é mostrado no retorno da busca$/) do |endereco|
  within_frame 0 do
    expect(page).to have_content endereco
  end
end
