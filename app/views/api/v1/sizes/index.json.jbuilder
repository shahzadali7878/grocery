@sizes.each do |size|
  json.set! size.id do
    json.partial! '/api/v1/sizes/size', size: size
  end
end
