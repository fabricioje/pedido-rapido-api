class Order
  class CreateService
    class InvalidParamsError < StandardError; end

    attr_reader :order
    attr_reader :errors

    def initialize(params = {})
      @params = params
      @order = nil
      @errors = {}
    end

    def call
      check_presence_of_itens_params
      check_emptyness_of_items_params

      create_order
      raise InvalidParamsError if @errors.present?
    end

    private

    def check_presence_of_itens_params
      unless @params.has_key?(:order_items)
        @errors[:order_items] = "Order items must be presence"
      end
    end

    def check_emptyness_of_items_params
      if @params[:order_items].blank?
        @errors[:order_items] = "Order items can't be blank"
      end
    end

    def create_order
      Order.transaction do
        @order = instantiate_order
        @order.save!
        line_items = @params[:order_items].map { |line_item_params| instantiate_line_items(line_item_params) }
        save!(line_items)
      end
    rescue ActiveRecord::RecordInvalid => e
      @errors.merge! e.record.errors.messages
    rescue ArgumentError => e
      @errors[:base] = e.message
    end

    def instantiate_order
      order_params = @params.except(:order_items)
      order = Order.new(order_params)
    end

    def instantiate_line_items(line_item_params)
      line_item = @order.order_items.build(line_item_params)
      line_item.validate!
      line_item
    end

    def save!(line_items)
      @order.save!
      line_items.each(&:save!)
    end
  end
end
