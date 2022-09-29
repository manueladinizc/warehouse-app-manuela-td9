require 'rails_helper'

describe 'Usuário vê detalhes de um galpão' do
    it 'e vê informações adicionais' do
        #Arrange
        user = User.create!(name: "Joao", email: 'joao@email.com', password: 'password')
        
        w = Warehouse.new(
            name: 'Aeroporto SP', 
            code: 'GRU', 
            city: 'Guarulhos', 
            area: 100_000, 
            address: 'Avenida do Aeroporto, 1000', 
            cep:'15000-000', 
            description: 'Galpão destinado para cargas internacionais',
            state: 'SP')
        w.save()
        #Act
        login_as(user)
        visit root_path
        click_on('Aeroporto SP')
        #Assert
        expect(page).to have_content('Galpão GRU')
        expect(page).to have_content('Nome: Aeroporto SP')
        expect(page).to have_content('Cidade: Guarulhos')
        expect(page).to have_content('Área: 100000 m2')
        expect(page).to have_content('Endereço: Avenida do Aeroporto, 1000 CEP: 15000-000')
        expect(page).to have_content('Galpão destinado para cargas internacionais')
        end

    it 'e volta para a tela inicial' do
        #Arrage
        user = User.create!(name: "Joao", email: 'joao@email.com', password: 'password')

        w = Warehouse.new(
            name: 'Aeroporto SP', 
            code: 'GRU', 
            city: 'Guarulhos', 
            area: 100_000, 
            address: 'Avenida do Aeroporto, 1000', 
            cep:'15000-000', 
            description: 'Galpão destinado para cargas internacionais',
            state: 'SP')
        w.save()
        #Act
        visit root_path
        login_as(user)
        click_on 'Sistema de Galpões e Estoque'
        click_on 'Aeroporto SP'
        click_on 'Voltar'
        #Assert
        expect(current_path).to eq(root_path)
    end
end


