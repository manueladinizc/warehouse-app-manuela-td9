class Supplier < ApplicationRecord
    validates :corporate_name, :brand_name, :registration_number, :full_address, :city, :state, :email, presence: true
    validates :registration_number, uniqueness: true
    validates :registration_number, format: {with: /\A\d{13}\z/, message: "Deve conter 13 dígitos"}
end
