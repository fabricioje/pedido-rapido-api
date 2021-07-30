module Front::V1
  class StatusController < ApiController
    def update
      status_service = Order::Status::UpdateService.new(order_id: order_id, status: status)
      status_service.()
      render "front/v1/orders/show", locals: { order: status_service.order }
    rescue => error
      render_error(fields: status_service.errors)
    end

    private

    def order_id
      params.require(:order_id)
    end

    def status
      params.require(:id)
    end
  end
end
