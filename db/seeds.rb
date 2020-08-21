# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'json'
require 'open-uri'

url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'

ingredient_serialized = open(url).read
ingredient = JSON.parse(ingredient_serialized)

ingredient["drinks"].each do |ingredient|
  Ingredient.create(name: ingredient["strIngredient1"])
  puts "Added #{ingredient["strIngredient1"]}"
end

def make_dose(cocktail)
  dose = Dose.new(description: "#{rand(1..5)} measure", ingredient_id: rand(1..100))
  dose.cocktail = cocktail
  dose.save!
  dose = Dose.new(description: "#{rand(1..5)} measure", ingredient_id: rand(1..100))
  dose.cocktail = cocktail
  dose.save!
end

def make_cocktail(url, name)
  file = URI.open(url)
  cocktail = Cocktail.new(name: "#{name.capitalize}")
  cocktail.photo.attach(io: file, filename: "#{name.downcase}.jpg", content_type: 'image/jpg')
  cocktail.save!

  make_dose(cocktail)
  make_dose(cocktail)
  puts "made #{cocktail.name}"
end

make_cocktail('https://res.cloudinary.com/dx9ybadbm/image/upload/v1598006907/cosmopolitan_k75xxk.jpg', "cosmopolitan")
make_cocktail("https://res.cloudinary.com/dx9ybadbm/image/upload/v1598006907/margarita_kdz1rr.jpg", "margarita")
make_cocktail('https://res.cloudinary.com/dx9ybadbm/image/upload/v1598006908/mojito_mxttyg.jpg', 'mojito')
make_cocktail('https://res.cloudinary.com/dx9ybadbm/image/upload/v1598006908/old_fashioned_coudcj.jpg', 'old fashioned')
make_cocktail('https://res.cloudinary.com/dx9ybadbm/image/upload/v1598006908/espresso_martini_iqwzjc.jpg', 'espresso martini')
make_cocktail('https://res.cloudinary.com/dx9ybadbm/image/upload/v1598006910/martini_fse9c7.jpg', 'martini')









