@colors.each do |color|
  json.set! color.id do
    json.partial! '/api/v1/colors/color', color: color
  end
end
