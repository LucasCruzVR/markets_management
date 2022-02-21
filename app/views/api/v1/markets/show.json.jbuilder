json.call(@market, :id, :name, :phone, :address)
json.products @market.markets_products do |market_products|
  json.call(market_products.product, :id, :name, :category, :barcode)
  json.call(market_products, :price)
end
