require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe '#valid?' do
  it 'name is mandatory' do
    #Arrange
    supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA', registration_number: '4207427100013',full_address: 'Av Nacoes Unidas, 1000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
    
    pm = ProductModel.new(name: '', weight: 8000, width: 70, height: 45, depth:10, sku:'0245-TV32CCdddDDDeee', supplier: supplier)
    #Act
    result = pm.valid?
    #Assert
    expect(result).to eq false
   end
  end

  describe '#valid?' do
  it 'sku is mandatory' do
    #Arrange
    supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA', registration_number: '4207427100013',full_address: 'Av Nacoes Unidas, 1000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
    
    pm = ProductModel.new(name: 'TV 32', weight: 8000, width: 70, height: 45, depth:10, sku:'', supplier: supplier)
    #Act
    result = pm.valid?
    #Assert
    expect(result).to eq false
   end
  end

end
