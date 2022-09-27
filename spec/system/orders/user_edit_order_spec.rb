require 'rails_helper'

describe 'Usuário edita pedido' do
    it 'e deve estar autenticado' do
        #Arrange
        carla = User.create!(name: 'Carla', email: 'carla@email.com', password: 'password')

        warehouse = Warehouse.create!(name: 'Galpão SP', code:'GRU', city:'São Paulo', area: '60_000', address: 'Av Paulista, 1000', cep: '80000-000', description: 'Galpão SP', state: "SP")
     
        supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number:'4207427100013', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')
     
        order = Order.create!(user: carla, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

        #Act
        visit edit_order_path(order.id)

        #Assert
        expect(current_path).to eq new_user_session_path
    end

    it 'com sucesso' do
        #Arrange
        joao = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')

        warehouse = Warehouse.create!(name: 'Galpão SP', code:'GRU', city:'São Paulo', area: '60_000', address: 'Av Paulista, 1000', cep: '80000-000', description: 'Galpão SP', state: "SP")
     
        supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number:'4207427100013', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')

        Supplier.create!(corporate_name: 'Spark LTDA', brand_name: 'Spark', registration_number:'4207427100027', full_address: 'Av das Palmas, 108', city: 'Bauru', state: 'SP', email: 'contato@s.com')
        
        order = Order.create!(user: joao, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
        #Act
        login_as(joao)
        visit root_path
        click_on 'Meus Pedidos'
        click_on order.code
        click_on 'Editar'
        fill_in 'Data Prevista de Entrega', with: '12/12/2022'
        select 'Spark LTDA', from: 'Fornecedor'
        click_on 'Gravar'
        #Assert
        expect(page).to have_content 'Pedido atualizado com sucesso.'
        expect(page).to have_content 'Fornecedor: Spark LTDA'
        expect(page).to have_content 'Data Prevista de Entrega: 12/12/2022'
    end

    it 'caso seja o responsável' do
        #Arrange
        carla = User.create!(name: 'Carla', email: 'carla@email.com', password: 'password')
        joao = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')

        warehouse = Warehouse.create!(name: 'Galpão SP', code:'GRU', city:'São Paulo', area: '60_000', address: 'Av Paulista, 1000', cep: '80000-000', description: 'Galpão SP', state: "SP")
     
        supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number:'4207427100013', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')
     
        order = Order.create!(user: joao, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

        #Act
        login_as(carla)
        visit edit_order_path(order.id)

        #Assert
        expect(current_path).to eq root_path
    end
end
