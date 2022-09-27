require 'rails_helper'

describe 'Usuário edita um pedido' do
    it 'e não é o dono' do
        #Arrange
        carla = User.create!(name: 'Carla', email: 'carla@email.com', password: 'password')
        joao = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')

        warehouse = Warehouse.create!(name: 'Galpão SP', code:'GRU', city:'São Paulo', area: '60_000', address: 'Av Paulista, 1000', cep: '80000-000', description: 'Galpão SP', state: "SP")
     
        supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number:'4207427100013', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')
     
        order = Order.create!(user: joao, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
        #Act
        login_as(carla)
        patch(order_path(order.id))
        #patch(order_path(order.id), params: {order: { supplier_id: 3}}), aqui exemplo que poderia passar parametros

        #Assert
        expect(response).to redirect_to(root_path)
    end
end