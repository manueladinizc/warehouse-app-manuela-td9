require 'rails_helper'

describe 'Usuário cadastra um modelo de produto' do
    it 'com sucesso' do
        #Arrange
        user = User.create!(name: "Joao", email: 'joao@email.com', password: 'password')

        supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA', registration_number: '4207427100013',full_address: 'Av Nacoes Unidas, 1000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
        other_supplier = Supplier.create!(brand_name: 'LG', corporate_name: 'LG do Brasil LTDA', registration_number: '9207427100015',full_address: 'Av Ibirapuera, 300', city: 'São Paulo', state: 'SP', email: 'contato@lg.com.br')
        #Act
        visit root_path
        login_as(user)
        
        within('nav') do 
            click_on 'Modelos de Produtos'
        end 
        click_on 'Cadastrar Novo'
        fill_in 'Nome', with: 'TV 40 polegadas'
        fill_in 'Peso', with: 10000
        fill_in 'Altura', with: 60
        fill_in 'Largura', with: 90
        fill_in 'Profundidade', with: 10
        fill_in 'SKU', with: '0245-LGcCCCdddDDDeee'
        #select supplier.brand_name, from: 'Fornecedor'
        select 'LG', from: 'Fornecedor'
        click_on 'Enviar'
        
        #Assert
        expect(page).to have_content 'Modelo de produto cadastrado com sucesso.'
        expect(page).to have_content 'TV 40 polegadas'
        #expect(page).to have_content 'Fornecedor: #{supplier.brand_name}'
        expect(page).to have_content 'Fornecedor: LG'
        expect(page).to have_content 'SKU: 0245-LGcCCCdddDDDeee'
        expect(page).to have_content 'Dimensão: 60cm x 90cm x 10cm'
        expect(page).to have_content '10000g'
    end

    it 'deve preencher todos os campos' do
         #Arrange
         user = User.create!(name: "Joao", email: 'joao@email.com', password: 'password')

         supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA', registration_number: '4207427100013',full_address: 'Av Nacoes Unidas, 1000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
         
         #Act
         visit root_path
         login_as(user)
        
         within('nav') do 
            click_on 'Modelos de Produtos'
         end 
         click_on 'Cadastrar Novo'
         fill_in 'Nome', with: ''
         fill_in 'SKU', with: ''
         click_on 'Enviar'
         
         #Assert
         expect(page).to have_content 'Não foi possivel cadastrar o modelo de produto.'
         
     end

end