require 'rails_helper'

RSpec.describe StockProduct, type: :model do
 describe 'gera um número de série' do
   it 'ao criar um StockProduct' do
    #Arrange
    user = User.create!(name:'Julia Almeida', email: 'julia@yahoo.com', password:'12345678')

    warehouse = Warehouse.create!(name: 'Santos Dumont', code: 'RIO', address: 'Endereço', cep: '25000-000', city: 'Rio', area: 1000, description: 'Alguma descrição', state: "RJ" )

    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number:'7584563215984', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')

    order = Order.create!(user: user, warehouse:warehouse, supplier: supplier, estimated_delivery_date: 1.week.from_now, status: :delivered)
    
    product = ProductModel.create!(name: 'Cadeira Gamer', supplier: supplier, weight: 5, height: 70, width: 75, depth: 80, sku: 'CAD-478597854123-478')

    
    #Act
    stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product)
   
    #Assert
    expect(stock_product.serial_number.length).to eq 20
   end

   it 'e não é modificado' do
    #Arrange
    user = User.create!(name:'Julia Almeida', email: 'julia@yahoo.com', password:'12345678')

    warehouse = Warehouse.create!(name: 'Santos Dumont', code: 'RIO', address: 'Endereço', cep: '25000-000', city: 'Rio', area: 1000, description: 'Alguma descrição', state: "RJ" )

    other_warehouse = Warehouse.create!(name: 'Galpão SP', code: 'SPP', address: 'Endereço', cep: '85000-000', city: 'São Paulo', area: 1000, description: 'Alguma descrição', state: "SP" )

    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number:'7584563215984', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')

    order = Order.create!(user: user, warehouse:warehouse, supplier: supplier, estimated_delivery_date: 1.week.from_now, status: :delivered)
    
    product = ProductModel.create!(name: 'Cadeira Gamer', supplier: supplier, weight: 5, height: 70, width: 75, depth: 80, sku: 'CAD-478597854123-478')

    stock_product = StockProduct.create!(order:order, warehouse: warehouse, product_model: product)

    original_serial_number = stock_product.serial_number
    #Act
    stock_product.update(warehouse: other_warehouse)
   
    #Assert
    expect(stock_product.serial_number).to eq original_serial_number
   end
 end
end
