class WarehousesController < ApplicationController
    
    before_action :set_warehouse, only: [:show, :edit, :update, :destroy]
    
    def show
    end

    def new
        @warehouse = Warehouse.new
    end

    def create
        @warehouse = Warehouse.new(warehouse_params)
        if @warehouse.save()
            redirect_to root_path, notice: 'Galpão cadastrado com sucesso.'
        else
            flash.now[:notice] = 'Galpão não cadastrado.'
            render 'new'
        end     
    end

    def edit
    end

    def update       
        if @warehouse.update(warehouse_params)
        redirect_to warehouse_path(@warehouse.id), notice: 'Galpão atualizado com sucesso'
        else
            flash.now[:notice] = 'Não foi possível atualizar o galpão'
            render 'edit'
        end
    end

    def destroy
        @warehouse.destroy
        redirect_to root_path, notice: 'Galpão removido com sucesso'
    end
        #Para evitar repetir nas actions a rotas que precisa passar o id, será criado um metodo.
        #Para definir que o metodo criado num controller não é action e só pode ser usado dentro dessa classe, deve-se colocar o private.
    private
    def set_warehouse 
        @warehouse = Warehouse.find(params[:id])
    end    

    def warehouse_params
        params.require(:warehouse).permit(:name, :code, :city, :description, :address, :cep, :area) #strong params
    end
end