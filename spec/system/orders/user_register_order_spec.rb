require 'rails_helper'

describe 'Usuário cadastra um pedido' do
    it'e deve estar autenticado' do
        #Arrange
        #Act
        visit root_path
        click_on 'Registrar Pedido'
        #Assert
        expect(current_path).to eq new_user_session_path
    end

    it'com sucesso' do
        #Arrange
        user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '12345678')
        
        Warehouse.create!(name: 'Galpão Recife', code:'REC', city:'Recife', area: '98_000', address: 'Av Beira-mar, 8000', cep: '89000-000', description: 'Galpão do Recife', state: "PE")
        warehouse = Warehouse.create!(name: 'Galpão Rio', code:'SDU', city:'Rio de Janeiro', area: '60_000', address: 'Av do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio', state: "RJ")


        Supplier.create!(corporate_name: 'BCG LTDA', brand_name: 'BCG', registration_number:'8887427100013', full_address: 'Av da Lagoa, 150', city: 'Bauru', state: 'SP', email: 'contato@bcg.com')
        supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number:'4207427100013', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')

        #Act
        login_as(user)
        visit root_path
        click_on 'Registrar Pedido'
        select 'SDU | Galpão Rio', from: 'Galpão Destino'
        select warehouse.name, from: 'Galpão Destino'
        select supplier.corporate_name, from: 'Fornecedor'
        fill_in 'Data Prevista de Entrega', with: '20/12/2022' 
        click_on 'Gravar'

        #Assert
        expect(page).to have_content 'Pedido registrado com sucesso.'
        expect(page).to have_content 'Galpão Destino: SDU | Galpão Rio'
        expect(page).to have_content 'Fornecedor: ACME LTDA'
        expect(page).to have_content 'Data Prevista de Entrega: 20/12/2022'
        expect(page).to have_content 'Usuário Responsável: Sergio | sergio@email.com'
        expect(page).not_to have_content 'Galpão Recife'
        expect(page).not_to have_content 'BCG LTDA'
    end
end