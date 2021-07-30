json.order do
  json.extract! order, :id, :name, :table_number, :status
  json.order_date order.created_at
  json.employee(order.employee, :id, :name)

  json.ordem_items do
    json.array! order.order_items do |item|
      json.extract! item, :id, :quantity, :comment
      json.product do
        json.extract! item.product, :id, :name, :description
        json.category(item.product.category, :id, :name)
      end
    end
  end
end
