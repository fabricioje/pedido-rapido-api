class Order
  class Status::UpdateService
    class InvalidParamsError < StandardError; end

    attr_reader :order
    attr_reader :errors

    def initialize(order_id:, status:)
      @order_id = order_id
      @status = status
      @order = nil
      @errors = {}
    end

    def call
      update_order_status

      raise InvalidParamsError if @errors.present?
    end

    private

    def update_order_status
      set_order
      update_status
    rescue ActiveRecord::RecordNotFound => e
      @errors[:base] = "Order not found"
    rescue ActiveRecord::RecordInvalid => e
      @errors.merge! e.record.errors.messages
    rescue ArgumentError => e
      @errors[:status] = e.message
    end

    def set_order
      @order = Order.find(@order_id)
    end

    def update_status
      @order.status = @status
      @order.save!
    end
  end
end
