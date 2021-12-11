# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

User.create!(name:  "Example User",
    username: "example username",
    email: "example@railstutorial.org",
    password:              "foobar",
    password_confirmation: "foobar"
    )

99.times do |n|
        name  = Faker::Name.name
        username = Faker::Name.first_name
        email = "example-#{n+1}@railstutorial.org"
        password = "password"
        User.create!(name: name,
                    username: username,
                    email: email,
                    password:              password,
                    password_confirmation: password
                   )
 end

users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.tweets.create!(tweet: content) }
end

users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?