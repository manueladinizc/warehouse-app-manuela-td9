require 'rails_helper'

describe 'Usuário vê seus priprios pedidos' do
 it 'e deve estar autenticado' do
    #Arrange
    #Act
    visit root_path
    click_on 'Meus Pedidos'
    #Assert
    expect(current_path).to eq new_user_session_path
 end

 it 'e não vê outros pedidos' do
   #Arrange
   joao = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')
   carla = User.create!(name: 'Joao', email: 'carla@email.com', password: 'password')

   warehouse = Warehouse.create!(name: 'Galpão SP', code:'GRU', city:'São Paulo', area: '60_000', address: 'Av Paulista, 1000', cep: '80000-000', description: 'Galpão SP', state: "SP")

   supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number:'4207427100013', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')

   first_order = Order.create!(user: joao, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now, status: 'pending')

   second_order = Order.create!(user: carla, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now, status: 'delivered')

   third_order = Order.create!(user: joao, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.week.from_now, status: 'canceled')
   #Act
   login_as(joao)
   visit root_path
   click_on 'Meus Pedidos'
   #Assert
   expect(page).to have_content first_order.code
   expect(page).to have_content 'Pendente'
   expect(page).not_to have_content second_order.code
   expect(page).not_to have_content 'Entregue'
   expect(page).to have_content third_order.code
   expect(page).to have_content 'Cancelado'
 end

 it 'e visita um pedido' do
  #Arrange
   joao = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')
  
   warehouse = Warehouse.create!(name: 'Galpão SP', code:'GRU', city:'São Paulo', area: '60_000', address: 'Av Paulista, 1000', cep: '80000-000', description: 'Galpão SP', state: "SP")

   supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number:'4207427100013', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')

   first_order = Order.create!(user: joao, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
  #Act
  login_as(joao)
   visit root_path
   click_on 'Meus Pedidos'
   click_on first_order.code
  #Assert
  expect(page).to have_content 'Detalhes do Pedido'
  expect(page).to have_content first_order.code
  expect(page).to have_content 'Galpão Destino: GRU | Galpão SP'
  expect(page).to have_content 'Fornecedor: ACME LTDA'
  formatted_date = I18n.localize(1.day.from_now.to_date)
  expect(page).to have_content "Data Prevista de Entrega: #{formatted_date}"
 end

 it 'e não visita pedidos de outros usuários' do
  #Arrange
   andre = User.create!(name: 'Andre', email: 'andre@email.com', password: 'password')
   joao = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')
   carla = User.create!(name: 'Carla', email: 'carla@email.com', password: 'password')

   warehouse = Warehouse.create!(name: 'Galpão SP', code:'GRU', city:'São Paulo', area: '60_000', address: 'Av Paulista, 1000', cep: '80000-000', description: 'Galpão SP', state: "SP")

   supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number:'4207427100013', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')

   first_order = Order.create!(user: joao, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
  #Act
  login_as(andre)
  visit order_path(first_order.id)
  #Assert
  expect(current_path).not_to eq order_path(first_order.id)
  expect(current_path).to eq root_path
  expect(page).to have_content 'Você não possui acesso a este pedido.'
  
 end
end
