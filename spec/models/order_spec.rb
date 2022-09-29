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

      it 'data estimada de entrega deve ser obrigatória' do
         #Arrange
         # user = User.create!(name:'Julia Almeida', email: 'julia@yahoo.com', password:'12345678')

         # warehouse = Warehouse.create!(name: 'Santos Dumont', code: 'RIO', address: 'Endereço', cep: '25000-000', city: 'Rio', area: 1000, description: 'Alguma descrição', state: "RJ" )

         # supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number:'7584563215984', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')
         
         #order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '')

         #"como se deseja verificar apenas um campo especifico, e o teste especifica isso no Act, é criar o order apenas verificando o campo desejado" 

         order = Order.new(estimated_delivery_date: '')
         #Act
         order.valid?
         result = order.errors.include?(:estimated_delivery_date)
         #Assert
         expect(result).to be true
      end

      it 'data estimada de entrega não deve ser passada' do
         #Arrange
         order = Order.new(estimated_delivery_date: 1.day.ago)
         #Act
         order.valid?         
         #Assert
         expect(order.errors.include?(:estimated_delivery_date)).to be true
         expect(order.errors[:estimated_delivery_date]).to include("deve ser futura.")
      end

      it 'data estimada de entrega não deve ser igual a hoje' do
         #Arrange
         order = Order.new(estimated_delivery_date: Date.today)
         #Act
         order.valid?
         #Assert
         expect(order.errors.include?(:estimated_delivery_date)).to be true
         expect(order.errors[:estimated_delivery_date]).to include("deve ser futura.")
      end

      it 'data estimada de entrega deve ser igual ou maior que amanhã' do
         #Arrange
         order = Order.new(estimated_delivery_date: 1.day.from_now)
         #Act
         order.valid?
         #Assert
         expect(order.errors.include?(:estimated_delivery_date)).to be false
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
      expect(result.length).to eq 10
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

     it 'e não deve ser modificado' do
     #Arrange
     u = User.create!(name:'Julia Almeida', email: 'julia@yahoo.com', password:'12345678')

      w = Warehouse.create!(name: 'Santos Dumont', code: 'RIO', address: 'Endereço', cep: '25000-000', city: 'Rio', area: 1000, description: 'Alguma descrição', state: "RJ" )

      s = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number:'7584563215984', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')

      order = Order.create!(user: u, warehouse:w, supplier: s, estimated_delivery_date: 1.week.from_now)

      original_code = order.code
      #Act
      order.update!(estimated_delivery_date: 1.month.from_now )
      #Assert
      expect(order.code).to eq(original_code)
   
     end
  end
end
