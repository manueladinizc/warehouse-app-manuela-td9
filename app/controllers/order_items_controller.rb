class OrderItemsController < ApplicationController 
    def new 
        @order = Order.find(params[:order_id])
        @products = @order.supplier.product_models #mostar apenas os produtos de um fornecedor
        @order_item = OrderItem.new
    end

    def create
        @order = Order.find(params[:order_id])
        order_item_params = params.require(:order_item).permit(:product_model_id, :quantity)

        @order.order_items.create(order_item_params) #pega os itens, cria um novo item e cria um novo item

        #@order_item = OrderItem.new(order_item_params) #passa os parametros
        #@order_item.order = @order #carrega o pedido
        #@order_item.save #grava

        redirect_to @order, notice: 'Item adicionado com sucesso'  #o show já mostra os itens
    end
end