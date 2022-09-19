class Warehouse < ApplicationRecord
    validates :name, :code, :city, :description, :address, :cep, :area, presence: true
    validates :name, :code, uniqueness: true
    validates :cep, format: {with: /\d{5}-\d{3}/, message: "Formato deve ser XXXXX-XXX"}
end
