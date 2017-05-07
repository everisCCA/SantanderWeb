#encoding: utf-8
#!/usr/bin/env ruby

Before('@agencia') do
  @home_page = HomePage.new
end

########################################################################################################################
#DADO
########################################################################################################################

Dado(/^que eu esteja na página inicial$/) do
  visit($DATA_URLS['producao'])
end

Dado(/^clico no menu inferior "([^"]*)"$/) do |menu|
  case
  when menu.include?("Agência")
      @home_page.wait_for_menu_inf_agencias
      @home_page.menu_inf_agencias.click
  end
end

Dado(/^clico no link "([^"]*)"$/) do |link|
  case link
    when 'Clique aqui'
      @home_page.click_aqui.click
    else
      raise "Link não encontrado!"
   end
end
