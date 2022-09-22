require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe '#valid?' do
    context 'presence' do
      it 'false when name is empty' do
        #Arrange
        warehouse = Warehouse.new(name: '', code: 'RIO', address: 'Endereço', cep: '25000-000', city: 'Rio', area: 1000, description: 'Alguma descrição', state: "RJ" )
        #Act
        result = warehouse.valid?
        #Assert
        expect(result).to eq false
      end 

      it 'false when code is empty' do
        #Arrange
        warehouse = Warehouse.new(name: 'Rio', code: '', address: 'Endereço', cep: '25000-000', city: 'Rio', area: 1000, description: 'Alguma descrição', state: "RJ" )
        #Act
        result = warehouse.valid?
        #Assert
        expect(result).to eq false
      end 

      it 'false when address is empty' do
        #Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: '', cep: '25000-000', city: 'Rio', area: 1000, description: 'Alguma descrição', state: "RJ" )
        #Act
        result = warehouse.valid?
        #Assert
        expect(result).to eq false
      end 

      it 'false when code is already in use' do
        #Arrange
        first_warehouse = Warehouse.create(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '25000-000', city: 'Rio', area: 1000, description: 'Alguma descrição', state: "RJ")

        second_warehouse = Warehouse.new(name: 'Niteroi', code: 'RIO', address: 'Avenida', cep: '35000-000', city: 'Niteroi', area: 1000, description: 'Outra descrição', state: "NT")
        #Act
        result = second_warehouse.valid?
        #Assert
        expect(result).to eq false
      end
    end
  end
  describe '#full_description' do
    it 'exibe o nome e o código' do
    #Arrange
        w = Warehouse.new(name: 'Galpão Cuiabá', code: 'CBA')

        #Act
        result = w.full_description()
        #Assert
        expect(result).to eq('CBA | Galpão Cuiabá')
    end
  end
end
