require 'rails_helper'

RSpec.describe Order, type: :model do
   describe '#valid?' do
   it 'deve ter um código' do
    #Arrange
    u = User.create!(name:'Julia Almeida', email: 'julia@yahoo.com', password:'12345678')

    w = Warehouse.create!(name: 'Santos Dumont', code: 'RIO', address: 'Endereço', cep: '25000-000', city: 'Rio', area: 1000, description: 'Alguma descrição', state: "RJ" )

    s = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number:'7584563215984', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')

    order = Order.new(user: u, warehouse:w, supplier: s, estimated_delivery_date: '2022-10-01')

    #Act
    result = order.valid?
    #Assert
    expect(result).to be true
   end
  end
  
  describe 'gera um código aleatório' do
     it 'ao criar um novo pedido' do
      #Arrange
      u = User.create!(name:'Julia Almeida', email: 'julia@yahoo.com', password:'12345678')

      w = Warehouse.create!(name: 'Santos Dumont', code: 'RIO', address: 'Endereço', cep: '25000-000', city: 'Rio', area: 1000, description: 'Alguma descrição', state: "RJ" )

      s = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number:'7584563215984', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')

      order = Order.new(user: u, warehouse:w, supplier: s, estimated_delivery_date: '2022-10-01')
      #Act
      order.save!
      result = order.code
      #Assert
      expect(result).not_to be_empty
      expect(result.length).to eq 8
     end

     it 'e o código é único' do
      #Arrange
      u = User.create!(name:'Julia Almeida', email: 'julia@yahoo.com', password:'12345678')

      w = Warehouse.create!(name: 'Santos Dumont', code: 'RIO', address: 'Endereço', cep: '25000-000', city: 'Rio', area: 1000, description: 'Alguma descrição', state: "RJ" )

      s = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number:'7584563215984', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')

      first_order = Order.create!(user: u, warehouse:w, supplier: s, estimated_delivery_date: '2022-10-01')

      second_order = Order.new(user: u, warehouse:w, supplier: s, estimated_delivery_date: '2022-11-15')
      #Act
      second_order.save!
      #result = order.code
      #Assert
      expect(second_order.code).not_to eq first_order.code
      
     end
  end
end
