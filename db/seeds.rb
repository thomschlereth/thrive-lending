# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Category.create([{ name: "meats" },
                 { name: "eggs" },
                 { name: "fruitsveggies" }])

16.times do
  Item.create(
    name: Faker::Commerce.product_name,
    description: Faker::Hipster.paragraph,
    price: Faker::Commerce.price,
    category_id: Category.all.sample.id,
    retired: false)
end
