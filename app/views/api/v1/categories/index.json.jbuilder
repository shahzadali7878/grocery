@categories.each do |category|
  json.set! category.id do
    json.partial! '/api/v1/categories/category', category: category
  end
end
