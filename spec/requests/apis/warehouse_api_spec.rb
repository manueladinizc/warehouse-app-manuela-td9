require 'rails_helper'

describe 'Warehouse API' do
    context 'GET /api/v1/warehouses/1' do
        it 'sucess' do
            #Arrange
            warehouse = Warehouse.create!(name: 'Aeroporto SP', code:'GRU', city:'São Paulo', area: '60_000', address: 'Av Paulista, 1000', cep: '80000-000', description: 'Galpão SP', state: "SP")
            #Act
            get "/api/v1/warehouses/#{warehouse.id}"
            #Assert
            expect(response.status).to eq 200
            expect(response.content_type).to include "application/json"
            json_response = JSON.parse(response.body) #formatar o corpo da repsosta como JSON. O conteúdo da resposta é convertido para JSON
            expect(json_response["name"]).to eq('Aeroporto SP')
            expect(json_response["code"]).to eq('GRU')
        end
    end
end