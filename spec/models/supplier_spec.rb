require 'rails_helper'

RSpec.describe Supplier, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"

#   describe '#valid?' do
#   context 'presence' do
#     it 'false when corporate_name is empty' do
#       #Arrange
#       supplier = Supplier.new(corporate_name: '', brand_name: 'ACME', registration_number:'434343', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')
#       #Act
#       result = supplier.valid?
#       #Assert
#       expect(result).to eq false
#     end 

#     it 'false when brand_name is empty' do
#       #Arrange
#       supplier = Supplier.new(corporate_name: 'ACME LTDA', brand_name: '', registration_number:'434343', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')
#       #Act
#       result = supplier.valid?
#       #Assert
#       expect(result).to eq false
#     end 

#     it 'false when registration number is empty' do
#       #Arrange
#       supplier = Supplier.new(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number:'', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')
#       #Act
#       result = supplier.valid?
#       #Assert
#       expect(result).to eq false
#     end 

#     it 'false when registration number is already in use' do
#       #Arrange
#       first_supplier = Supplier.create(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number:'434343', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')

#       second_supplier = Supplier.new(corporate_name: 'AC LTDA', brand_name: 'AC', registration_number:'434343', full_address: 'Av das Palmas, 1200', city: 'Cidade Bauru', state: 'SS', email: 'contatoAC@acme.com')
#       #Act
#       result = second_supplier.valid?
#       #Assert
#       expect(result).to eq false
#     end
#   end
# end

end
