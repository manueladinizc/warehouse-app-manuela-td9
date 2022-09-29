require 'rails_helper'

describe 'Usuário remove um galpão' do
    it 'com sucesso' do
        #Arrange
        user = User.create!(name: "Joao", email: 'joao@email.com', password: 'password')

        warehouse = Warehouse.create!(name: 'Belo Horizonte', code: 'BHZ', area: 20000, cep: '46000-000', city: 'Belo Horizonte', description: 'Galpão para cargas mineiras', address: 'Av Tiradentes, 20', state: "BH" )
        #Act
        visit root_path
        login_as(user)
        click_on 'Sistema de Galpões e Estoque'
        click_on 'Belo Horizonte'
        click_on 'Remover'
        #Assert
        expect(current_path).to eq root_path
        expect(page).to have_content 'Galpão removido com sucesso'
        expect(page).not_to have_content 'Belo Horizonte'
        expect(page).not_to have_content 'BHZ'
    end


    it 'e não apaga outros galpões' do
        #Arrange
        user = User.create!(name: "Joao", email: 'joao@email.com', password: 'password')

        first_warehouse = Warehouse.create!(name: 'Cuiaba', code: 'CWB', area: 10000, cep: '56000-000', city: 'Cuiabá', description: 'Galpão no centro do país', address: 'Av dos Jacares, 1000' , state: "MG" )
        second_warehouse = Warehouse.create!(name: 'Belo Horizonte', code: 'BHZ', area: 20000, cep: '46000-000', city: 'Belo Horizonte', description: 'Galpão para cargas mineiras', address: 'Av Tiradentes, 20', state: "BH" )
        #Act
        visit root_path
        login_as(user)
        click_on 'Sistema de Galpões e Estoque'
        click_on 'Cuiaba'
        click_on 'Remover'
        #Assert
        expect(current_path).to eq root_path
        expect(page).to have_content 'Galpão removido com sucesso'
        expect(page).to have_content 'Belo Horizonte'
        expect(page).not_to have_content 'Cuiaba'
    end
end