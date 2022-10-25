class Api::V1::WarehousesController < ActionController::API
    def show
        #quando o código puder apresentar algum erro se usa "begin/rescue"
        #warehouse = Warehouse.find(params[:id])
        
        
        #warehouse = Warehouse.find_by(id: params[:id]) #devolve nil
        #if warehouse.nil?
            #return render status: 404
        #end   
            #return render status: 200, json: warehouse.as_json(except: [:created_at, :updated_at])
            #render status: 200, json: "{ }"
            #metodo, status http desejado, conteúdo json
        
            begin #a seguir as linhas que podem dar erro"
                warehouse = Warehouse.find(params[:id]) #para o find, precisa fazer o tratamento de erros
                return render status: 200, json: warehouse.as_json(except: [:created_at, :updated_at])
            rescue #a seguir em caso de erro, aslinhas que serão mostradas
                render status: 404
            end   
    end
    def index
        warehouses = Warehouse.all.order(:name)
        #render status: 200, json: "[]" #objeto vazio
        render status: 200, json: warehouses #converte os warehouses em json
    end
end