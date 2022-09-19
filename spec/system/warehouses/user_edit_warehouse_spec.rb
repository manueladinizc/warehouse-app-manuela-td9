require 'rails_helper'

describe 'Usuário edita um galpão' do
    it 'a partir da página de detalhes' do
        #Arran
        warehouse = Warehouse.create!(name: 'Aeroporto Rio', code:'SDU', city:'Rio de Janeiro', area: '60_000', address: 'Av do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio', state: "RJ")
        
        #Act
        visit root_path
        click_on 'Aeroporto Rio'
        click_on 'Editar'
        #Assert
        expect(page). to have_content 'Editar Galpão'
        expect(page).to have_field('Nome', with: 'Aeroporto Rio')
        expect(page).to have_field('Descrição', with: 'Galpão do Rio')
        expect(page).to have_field('Código', with: 'SDU')
        expect(page).to have_field('Endereço', with: 'Av do Porto, 1000')
        expect(page).to have_field('Cidade', with: 'Rio de Janeiro')
        expect(page).to have_field('CEP', with: '20000-000')
        expect(page).to have_field('Área', with: '60000')
    end

    it 'com sucesso' do
        #Arran
        warehouse = Warehouse.create!(name: 'Aeroporto Rio', code:'SDU', city:'Rio de Janeiro', area: '60_000', address: 'Av do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio', state: "RJ")
        
        #Act
        visit root_path
        click_on 'Aeroporto Rio'
        click_on 'Editar'
        fill_in 'Nome', with: 'Galpão Internacional'
        fill_in 'Área', with: '200000'
        fill_in 'Endereço', with: 'Av do Porto, 1001'
        fill_in 'CEP', with: '16000-000'
        click_on 'Enviar'
        #Assert
        expect(page).to have_content 'Galpão atualizado com sucesso'
        expect(page).to have_content 'Nome: Galpão Internacional'
        expect(page).to have_content 'Endereço: Av do Porto, 1001'
        expect(page).to have_content 'Área: 200000 m2'
        expect(page).to have_content 'CEP: 16000-000'
    end

    it 'e mantém os campos obrigatórios' do
        #Arran
        warehouse = Warehouse.create!(name: 'Aeroporto Rio', code:'SDU', city:'Rio de Janeiro', area: '60_000', address: 'Av do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio', state: "RJ")
        
        #Act
        visit root_path
        click_on 'Aeroporto Rio'
        click_on 'Editar'
        fill_in 'Nome', with: ''
        fill_in 'Área', with: ''
        fill_in 'Endereço', with: ''
        click_on 'Enviar'
        #Assert
        expect(page).to have_content 'Não foi possível atualizar o galpão'
              
    end
end