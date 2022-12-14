require 'rails_helper'

describe 'Usuário visita tela inicial' do
    it 'e vê o nome do app' do
        #Arrange
        user = User.create!(name: "Joao", email: 'joao@email.com', password: 'password')
        #Act
        visit(root_path)
        login_as(user)
        #Assert
        expect(page).to have_content('Sistema de Galpões e Estoque')
        expect(page).to have_link('Sistema de Galpões e Estoque', href: root_path)
    end

    it 'e vê os galpões cadastrados' do
        #Arrange
        user = User.create!(name: "Joao", email: 'joao@email.com', password: 'password')
        #cadastrar 2 galpões: Rio e Maceio
        Warehouse.create(name: 'Rio', code:'SDU', city:'Rio de Janeiro', area: '60_000', address: 'Av do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio', state: "RJ")
        Warehouse.create(name: 'Maceio', code:'MCZ', city:'Maceio', area: '50_000', address: 'Av Atlantica, 50', cep: '80000-000', description: 'Perto do Aeroporto' , state: "MA")

        #Act
        visit(root_path)
        login_as(user)
        #Assert
        expect(page).not_to have_content('Não existe galpões cadastrados')
        expect(page).to have_content('Rio')
        expect(page).to have_content('Código: SDU')
        expect(page).to have_content('Cidade: Rio de Janeiro')
        expect(page).to have_content('60000 m2')

        expect(page).to have_content('Maceio')
        expect(page).to have_content('Código: MCZ')
        expect(page).to have_content('Cidade: Maceio')
        expect(page).to have_content('50000 m2')
    end

    it 'e não existem galpões cadastrados' do
        #Arrange
        user = User.create!(name: "Joao", email: 'joao@email.com', password: 'password')
        #Act
        visit(root_path)
        login_as(user)
        #Assert
        expect(page).to have_content('Não existe galpões cadastrados')
    end
end
