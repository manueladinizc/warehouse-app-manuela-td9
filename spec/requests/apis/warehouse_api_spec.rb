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
            json_response = JSON.parse(response.body) #formatar o corpo da resposta como JSON. O conteúdo da resposta é convertido para JSON
            expect(json_response["name"]).to eq('Aeroporto SP')
            expect(json_response["code"]).to eq('GRU')
            expect(json_response.keys).not_to include("created_at")
            expect(json_response.keys).not_to include("updated_at")
        end
        
        it 'fail warehouse not found' do
            #Arrange
            #Assert
            get "/api/v1/warehouses/99999"
            #Act
            expect(response.status).to eq 404
        end
    end

    context 'GET /api/v1/warehouses' do
        it 'list all warehouses ordered by name' do
            #Arrange
            Warehouse.create!(name: 'Galpão SP', code:'GRU', city:'São Paulo', area: '60_000', address: 'Av Paulista, 1000', cep: '80000-000', description: 'Galpão SP', state: "SP")

            Warehouse.create!(name: 'Galpão Rio', code:'RIO', city:'Rio de Janeiro', area: '60_000', address: 'Av mar, 1000', cep: '90000-000', description: 'Galpão RIO', state: "RJ")
            #Act
            get '/api/v1/warehouses'
            #Assert
            expect(response.status).to eq 200
            expect(response.content_type).to include 'application/json'
            json_response = JSON.parse(response.body) #conteudo body vazio foi passado no controllercomo objeto, converte numa variável usando o modo JSON do ruby            
            expect(json_response.length).to eq 2
            expect(json_response[1]["name"]).to eq "Galpão SP"
            expect(json_response[0]["name"]).to eq "Galpão Rio"

        end

        it 'return empty if is no warehouse' do
            #Act
            get '/api/v1/warehouses'
            expect(response.status).to eq 200
            expect(response.content_type).to include 'application/json'
            json_response = JSON.parse(response.body)
            expect(json_response).to eq []


        end
    end
end