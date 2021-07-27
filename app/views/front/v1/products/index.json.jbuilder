json.products do
  json.array! @loading_service.records do |product|
    json.extract! product, :id, :name, :description
    json.category(product.category, :id, :name)
  end
end

json.meta do
  json.partial! 'shared/pagination', pagination: @loading_service.pagination
end