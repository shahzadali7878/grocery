@sub_categories.each do |sub_category|
  json.set! sub_category.id do
    json.partial! '/api/v1/sub_categories/sub_category', sub_category: sub_category
  end
end
