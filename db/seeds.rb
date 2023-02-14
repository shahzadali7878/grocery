# # #
# Create Colors
#
{ green: '#00FF00', red: '#FF0000', blue: '#0000FF' }.each do |name, code|
  Color.create(name: name, code: code)
end
#
# Create Colors
# # #

# # #
# Create Sizes
#
{ small: 's', medium: 'm', large: 'l' }.each do |name, code|
  Size.create(name: name, code: code)
end
#
# Create Sizes
# # #

# # #
# Create Categories
#
dairy_category = Category.create(name: 'Dairy', description: 'Quality Dairy')
meat_category  = Category.create(name: 'Meat',  description: 'Quality Meat')
#
# Create Categories
# # #

# # #
# Create SubCategories
#
dairy_category.sub_categories.create(name: 'Nestle', description: 'Quality Nestle Items')
meat_category.sub_categories.create(name: 'Beef',  description: 'Quality Beef Meat')
#
# Create SubCategories
# # #
