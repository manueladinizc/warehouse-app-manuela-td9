class Warehouse < ApplicationRecord
    validates :name, :code, :city, :description, :address, :cep, :area, :state, presence: true
    validates :name, :code, uniqueness: true
    validates :cep, format: {with: /\A\d{5}-\d{3}\z/, message: "Formato deve ser XXXXX-XXX"}
end
