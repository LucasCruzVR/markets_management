json.results @markets do |market|
    json.call(market, :id, :name, :phone, :address)
end