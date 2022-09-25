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

end