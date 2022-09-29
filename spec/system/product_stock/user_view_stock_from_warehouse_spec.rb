require 'rails_helper'

describe 'Usuário vê o estoque' do
    it 'na tela do galpão' do
        #Arrange
        user = User.create!(name: 'Andre', email: 'andre@email.com', password: 'password')
        
        warehouse = Warehouse.create!(name: 'Galpão SP', code:'GRU', city:'São Paulo', area: '60_000', address: 'Av Paulista, 1000', cep: '80000-000', description: 'Galpão SP', state: "SP")

        supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA', registration_number: '4207427100013',full_address: 'Av Nacoes Unidas, 1000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
    
        order = Order.create!(user: user, supplier: supplier, warehouse: warehouse, estimated_delivery_date: 1.day.from_now)

        product_tv = ProductModel.create!(name: 'TV 40 Polegadas', weight: 8000, width: 70, height: 45, depth:10, sku:'1245-TV32CCdddDDDeee', supplier: supplier)
        
        product_soundbar = ProductModel.create!(name: 'SoundBar 7.1', weight: 8000, width: 70, height: 45, depth:10, sku:'0245-SB71CCdddDDDeee', supplier: supplier)
        
        product_notebook = ProductModel.create!(name: 'Notebook i5 16GB', weight: 8000, width: 70, height: 45, depth:10, sku:'3245-NTI5CCdddDDDeee', supplier: supplier)

        3.times { StockProduct.create!(order: order, warehouse: warehouse, product_model: product_tv) }
        2.times { StockProduct.create!(order: order, warehouse: warehouse, product_model: product_notebook) }
        #Act
        login_as user
        visit root_path
        click_on 'Galpão SP'
        #Assert
        expect(page).to have_content 'Itens em Estoque'
        expect(page).to have_content '3 x 1245-TV32CCdddDDDeee'
        expect(page).to have_content '2 x 3245-NTI5CCdddDDDeee'
        expect(page).not_to have_content '0245-SB71CCdddDDDeee'
    end
end