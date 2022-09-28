require 'rails_helper'

describe 'Usuário adiciona itens ao pedido' do
    it 'com sucesso' do
        #Arrange
        user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')

        warehouse = Warehouse.create!(name: 'Galpão SP', code:'GRU', city:'São Paulo', area: '60_000', address: 'Av Paulista, 1000', cep: '80000-000', description: 'Galpão SP', state: "SP")
     
        supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number:'4207427100013', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')
              
        order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

        product_a = ProductModel.create!(name: 'Produto A', weight: 8000, width: 70, height: 45, depth:10, sku:'PDTA-TV32CCdddDDDeee', supplier: supplier)

        product_b = ProductModel.create!(name: 'Produto B', weight: 8000, width: 70, height: 45, depth:10, sku:'PDTB-TV32CCdddDDDeee', supplier: supplier)
        #Act
        login_as(user)
        visit root_path
        click_on 'Meus Pedidos'
        click_on order.code
        click_on 'Adicionar Item'
        
        select 'Produto A', from: 'Produto'
        fill_in 'Quantidade', with: '8'
        click_on 'Gravar'

        #Assert
        expect(current_path).to eq order_path(order.id)
        expect(page).to have_content 'Item adicionado com sucesso'
        expect(page).to have_content '8 x Produto A'
    end

    it 'e não vê produtos de outro fornecedor' do
         #Arrange
         user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')

         warehouse = Warehouse.create!(name: 'Galpão SP', code:'GRU', city:'São Paulo', area: '60_000', address: 'Av Paulista, 1000', cep: '80000-000', description: 'Galpão SP', state: "SP")
      
         supplier_a = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number:'4207427100013', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')

         supplier_b = Supplier.create!(corporate_name: 'Spark LTDA', brand_name: 'Spark', registration_number:'4207427100050', full_address: 'Av das Palmas, 104', city: 'Bauru', state: 'SP', email: 'contato@s.com')
               
         order = Order.create!(user: user, warehouse: warehouse, supplier: supplier_a, estimated_delivery_date: 1.day.from_now)
 
         product_a = ProductModel.create!(name: 'Produto A', weight: 8000, width: 70, height: 45, depth:10, sku:'PDTA-TV32CCdddDDDeee', supplier: supplier_a)
 
         product_b = ProductModel.create!(name: 'Produto B', weight: 8000, width: 70, height: 45, depth:10, sku:'PDTB-TV32CCdddDDDeee', supplier: supplier_b)
         #Act
         login_as(user)
         visit root_path
         click_on 'Meus Pedidos'
         click_on order.code
         click_on 'Adicionar Item'
                   
         #Assert
         expect(page).to have_content 'Produto A'
         expect(page).not_to have_content 'Produto B'
    end

end