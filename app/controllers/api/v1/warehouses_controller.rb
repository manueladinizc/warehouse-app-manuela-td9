class Api::V1::WarehousesController < ActionController::API
    def show
        warehouse = Warehouse.find(params[:id])
        render status: 200, json: warehouse
        #render status: 200, json: "{ }"
        #metodo, status http desejado, conteúdo json
    end
end