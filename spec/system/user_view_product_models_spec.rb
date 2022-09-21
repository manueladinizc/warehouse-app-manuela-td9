require 'rails_helper'

describe 'Usuário vê models de produtos' do
   it 'se estiver autenticado' do
    #Arrange
    
    #Act
    visit root_path
    
    within('nav') do
        click_on 'Modelos de Produtos'
    end
    #Assert
    expect(current_path).to eq new_user_session_path

   end
    
    it 'a partir do menu' do
        #Arrange
        user = User.create!(name: "Joao", email: 'joao@email.com', password: 'password')
        #Act
        visit root_path
        login_as(user)
        within('nav') do 
            click_on 'Modelos de Produtos'
        end 
        #Assert
        expect(current_path).to eq product_models_path
    end

    it 'com sucesso' do 
        #Arrange
        user = User.create!(name: "Joao", email: 'joao@email.com', password: 'password')

        supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA', registration_number: '4207427100013',full_address: 'Av Nacoes Unidas, 1000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')

        ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth:10, sku:'0245-TV32CCdddDDDeee', supplier: supplier)
        ProductModel.create!(name: 'SoundBar 7.1 Surround', weight: 3000, width: 80, height: 15, depth:20, sku:'0245-SOU2CCdddDDDeee', supplier: supplier)
        #Act        
        visit root_path
        login_as(user)
        within('nav') do 
            click_on 'Modelos de Produtos'
        end
        #Assert
        expect(page).to have_content 'TV 32'
        expect(page).to have_content '0245-TV32CCdddDDDeee'
        expect(page).to have_content 'Samsung'
        expect(page).to have_content 'SoundBar 7.1 Surround'
        expect(page).to have_content '0245-SOU2CCdddDDDeee'
        expect(page).to have_content 'Samsung'

    end

    it ' e não existem produtos cadastrados' do
        #Arrange
        user = User.create!(name: "Joao", email: 'joao@email.com', password: 'password')
        #Act
        visit root_path
        login_as(user)
        click_on 'Modelos de Produtos'
        #Assert
        expect(page).to have_content 'Nenhum modelo de produto cadastrado.'
    end
end