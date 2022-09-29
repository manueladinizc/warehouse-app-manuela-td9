require 'rails_helper'

describe 'Usuário vê detalhes do fornecedor' do
    it 'a partir da tela inicial' do
        #Arrange
        user = User.create!(name: "Joao", email: 'joao@email.com', password: 'password')

        Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number:'4207427100013', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')
        #Act 
        visit root_path
        login_as(user)
        click_on 'Fornecedores'
        click_on 'ACME'
        #Assert
        expect(page).to have_content('ACME LTDA')
        expect(page).to have_content('Documento: 4207427100013')
        expect(page).to have_content('Endereço: Av das Palmas, 100 - Bauru - SP')
        expect(page).to have_content('E-mail: contato@acme.com')
        
    end

    it 'e volta para a tea iniial' do
        #Arrange
        user = User.create!(name: "Joao", email: 'joao@email.com', password: 'password')

        Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number:'4207427100013', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')
        #Act
        visit root_path
        login_as(user)
        click_on 'Fornecedores'
        click_on 'ACME'
        click_on 'Voltar'
        expect(current_path).to eq root_path
    end
end