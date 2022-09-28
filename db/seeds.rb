# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')

warehouse = Warehouse.create!(name: 'Galpão SP', code:'GRU', city:'São Paulo', area: '60_000', address: 'Av Paulista, 1000', cep: '80000-000', description: 'Galpão SP', state: "SP")

Warehouse.create!(name: 'Aeroporto Rio', code:'SDU', city:'Rio de Janeiro', area: '60_000', address: 'Av do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio', state: "RJ")
     
supplier_a = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number:'4207427100013', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@acme.com')

supplier_b Supplier.create!(corporate_name: 'Spark LTDA', brand_name: 'Spark', registration_number:'4207427100050', full_address: 'Av das Palmas, 104', city: 'Bauru', state: 'SP', email: 'contato@s.com')
              
Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 30.days.from_now)

ProductModel.create!(name: 'TV 32 Polegadas', weight: 8000, width: 70, height: 45, depth:10, sku:'PDTA-TV32CCdddDDDeee', supplier: supplier_a)

ProductModel.create!(name: 'TV 50 Polegadas', weight: 8000, width: 70, height: 45, depth:10, sku:'PDTB-TV32CCdddDDDeee', supplier: supplier_b)