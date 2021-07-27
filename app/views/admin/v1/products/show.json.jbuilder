json.product do
  json.(@product, :id, :name, :description)
  json.category(@product.category, :id, :name)
end