# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Employee.create(
  name: "Admin",
  email: "admin@admin.com",
  occupation: :admin,
  password: "admin123",
  password_confirmation: "admin123",
) unless Employee.exists?(email: "admin@admin.com")

categories = []
rand(20..100).times do |n|
  categories << Category.create(name: Faker::Restaurant.type)
end

rand(20..100).times do |n|
  Product.create(
    name: Faker::Food.dish,
    description: Faker::Food.description,
    price: Faker::Commerce.price(range: 1.0..400.0),
    category: categories.sample,
  )
end

10..100.times do |n|
  Employee.create(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    occupation: [:admin, :waiter, :cooker].sample,
    password: "123456",
    password_confirmation: "123456",
  )
end
