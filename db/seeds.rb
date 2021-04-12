require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
FollowerFollowed.destroy_all
UserLike.destroy_all
Post.destroy_all
User.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('follower_followeds')
ActiveRecord::Base.connection.reset_pk_sequence!('user_likes')
ActiveRecord::Base.connection.reset_pk_sequence!('posts')
ActiveRecord::Base.connection.reset_pk_sequence!('users')


100.times do
  User.create!(name:"#{Faker::Games::WarhammerFantasy.hero.split(' ')[0]} #{Faker::Science.scientist.split(' ')[0]} #{Faker::FunnyName.two_word_name.split(' ')[1]}", email: Faker::Internet.email , password: "badpassword", password_confirmation: "badpassword")
end

100.times do
  Post.create!(content: Faker::GreekPhilosophers.quote, only_followers: [true,false].sample, user_id: rand(1..100))
end

100.times do
  UserLike.create!(user_id: rand(1..100).to_s, post_id: rand(1..100).to_s)
  FollowerFollowed.create!(follower_id: rand(1..100).to_s, followed_id: rand(1..100).to_s)
end
