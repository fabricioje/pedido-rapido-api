module Front::V1
  class OrdersController < ApiController
    before_action :find_order, only: [:update, :destroy, :show]

    def index
      @loading_service = Shared::ModelLoadingService.new(Order.all, searchable_params)
      @loading_service.call
    end

    def create
      order_service = Order::CreateService.new(order_params)
      order_service.call()
      render :show, locals: { order: order_service.order }
    rescue => error
      render_error(fields: order_service.errors)
    end

    def show
      render :show, locals: { order: @order }
    end

    private

    def order_params
      return {} unless params.has_key?(:order)
      params.require(:order).permit(:name, :table_number, :employee_id,
                                    order_items: [:product_id, :quantity, :comment])
    end

    def find_order
      @order = Order.find(params[:id])
    end

    def searchable_params
      params.permit({ search: [:id, :name, :table_number] }, { order: {} }, :status, :page, :length)
    end
  end
end
