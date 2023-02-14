@products.each do |product|
  json.set! product.id do
    json.partial! '/api/v1/products/product', product: product
  end
end
