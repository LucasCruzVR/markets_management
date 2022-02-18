json.results @products do |product|
  json.call(product, :id, :name, :category, :barcode)
end
