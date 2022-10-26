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
        it 'and raise internal error' do
            allow(Warehouse).to receive(:all).and_raise(ActiveRecord::QueryCanceled)

            get '/api/v1/warehouses'

            expect(response).to have_http_status(500)
        end
    end

        context 'POST /api/v1/warehouses' do
            it 'success' do
                #Arrange
                warehouse_params = {warehouse: { name: 'Galpão SP', code:'GRU', city:'São Paulo', area: 100000, address: 'Av Paulista, 1000', cep: '80000-000', description: 'Galpão SP', state: "SP" }} #variável com um hash
                #Act
                post '/api/v1/warehouses', params: warehouse_params
                #para o post é passado a url e o parametro
                #Asset
                #expect(response).to have_http_status(201)
                expect(response).to have_http_status(:created)
                expect(response.content_type).to include 'application/json'
                json_response = JSON.parse(response.body)
                
                expect(json_response["name"]).to eq('Galpão SP')
                expect(json_response["code"]).to eq('GRU')
                expect(json_response["city"]).to eq('São Paulo')
                expect(json_response["area"]).to eq(100000)
                expect(json_response["address"]).to eq('Av Paulista, 1000')
                expect(json_response["cep"]).to eq('80000-000')
                expect(json_response["description"]).to eq('Galpão SP')
                expect(json_response["state"]).to eq('SP')
    
            end
            it 'fail if parameters are not complete' do
                #Arrange
                warehouse_params = {warehouse: { name: 'Galpão SP', code:'GRU'}}
                #Act
                post '/api/v1/warehouses', params: warehouse_params
                #Assert

                expect(response).to have_http_status(412)
                expect(response.body).not_to include 'Nome não pode ficar em branco'
                expect(response.body).not_to include 'Código não pode ficar em branco'
                expect(response.body).to include 'Cidade não pode ficar em branco'
            end
        end  

        it 'fail if theres an internal error' do
            #Arrange
            allow(Warehouse).to receive(:new).and_raise(ActiveRecord::ActiveRecordError)
            warehouse_params = {warehouse: { name: 'Galpão SP', code:'GRU', city:'São Paulo', area: 100000, address: 'Av Paulista, 1000', cep: '80000-000', description: 'Galpão SP', state: "SP" }}
            #Act
            post '/api/v1/warehouses', params: warehouse_params
            #Assert
            expect(response).to have_http_status(500)
        end
end