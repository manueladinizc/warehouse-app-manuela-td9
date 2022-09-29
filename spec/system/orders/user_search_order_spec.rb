require 'rails_helper'
describe 'Usuário busca por um pedido' do
    it 'a partir do menu' do
       #Arrange
       user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')
       #Act
       login_as(user)
       visit root_path
       #Assert
       within('header nav') do
           expect(page).to have_field('Buscar Pedido')
           expect(page).to have_button('Buscar')
       end
    end


    

    it 'e deve estar autenticado' do
        #Arrange
       
        #Act
        visit root_path
       
        #Assert
       within('header nav') do
        expect(page).not_to have_field('Buscar Pedido')
        expect(page).not_to have_button('Buscar')
       end
    end

       it 'e encontra um pedido' do
        #Arrange
        user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')

        warehouse = Warehouse.create!(name: 'Galpão Rio', code:'SDU', city:'Rio de Janeiro', area: '60_000', address: 'Av do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio', state: "RJ")

        supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number:'4207427100013', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')

        order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
        #Act
        login_as(user)
        visit root_path
        fill_in 'Buscar Pedido', with: order.code
        click_on 'Buscar'
       
        #Assert
        expect(page).to have_content "Resultados da Busca por: #{order.code}"
        expect(page).to have_content '1 pedido encontrado'
        expect(page).to have_content "Código: #{order.code}"
        expect(page).to have_content "Galpão Destino: SDU | Galpão Rio"
        expect(page).to have_content "Fornecedor: ACME LTDA"
    end

    it 'e encontra múltiplos pedidos' do
        #Arrange
        user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')

        first_warehouse = Warehouse.create!(name: 'Galpão SP', code:'GRU', city:'São Paulo', area: '60_000', address: 'Av Paulista, 1000', cep: '80000-000', description: 'Galpão SP', state: "SP")

        second_warehouse = Warehouse.create!(name: 'Galpão Rio', code:'SDU', city:'Rio de Janeiro', area: '60_000', address: 'Av do Porto, 5000', cep: '20000-000', description: 'Galpão do Rio', state: "RJ")

        supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number:'4207427100013', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')

        allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('GRU1234500')
        first_order = Order.create!(user: user, warehouse: first_warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
        
        allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('GRU9876500')
        second_order = Order.create!(user: user, warehouse: first_warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

        allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('SDU0000000')
        third_order = Order.create!(user: user, warehouse: second_warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
        #Act
        login_as(user)
        visit root_path
        fill_in 'Buscar Pedido', with: 'GRU'
        click_on 'Buscar'
       
        #Assert
        expect(page).to have_content('2 pedidos encontrados')
        expect(page).to have_content('GRU1234500')
        expect(page).to have_content('GRU9876500')
        expect(page).to have_content "Galpão Destino: GRU | Galpão SP"
        expect(page).not_to have_content('SDU0000000')
        expect(page).not_to have_content "Galpão Destino: SDU | Galpão Rio"
        
     
    end

end