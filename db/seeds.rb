# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
#
ActiveRecord::Base.transaction do
  20.times do |index|
    user = User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, age: 30)
    user.posts.create!(title: Faker::Lorem.word, content: Faker::Lorem.paragraph)
  end
end
