require 'rails_helper'

describe 'Usuário vê fornecedores' do 
     it 'a partir do menu' do
        #Arrange
        user = User.create!(name: "Joao", email: 'joao@email.com', password: 'password')
        #Act
        visit root_path
        login_as(user)
        within('nav') do
            click_on 'Fornecedores'
        end
        #Assert
        expect(current_path).to eq suppliers_path
     end

     it 'com sucesso' do
        #Arrange
        user = User.create!(name: "Joao", email: 'joao@email.com', password: 'password')

        Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number:'4207427100013', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')
        Supplier.create!(corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark', registration_number: '7807427100013', full_address: 'Torre da Insdústria, 1', city: 'Teresina', state: 'PI', email: 'contato@spark.com')
        #Act
        visit root_path
        login_as(user)
        click_on 'Fornecedores'
        #Assert
        expect(page).to have_content('Fornecedores')
        expect(page).to have_content('ACME')
        expect(page).to have_content('Bauru - SP')
        expect(page).to have_content('Spark')
        expect(page).to have_content('Teresina - PI')
     end

     it 'e não existem fornecedores cadastrados' do
      #Arrange
      user = User.create!(name: "Joao", email: 'joao@email.com', password: 'password')
      #Act
      visit root_path
      login_as(user)
      click_on 'Fornecedores'
      #Assert
      expect(page).to have_content 'Não existem fornecedores cadastrados.'
     end

end