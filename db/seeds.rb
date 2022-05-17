# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'


User.delete_all
Event.delete_all

10.times do |i|
    firstname = Faker::Name.first_name
    User.create!(
        email: "#{firstname}.#{i}@yopmail.com",
        password: 'password',
        password_confirmation: 'password',
        description: Faker::TvShows::FamilyGuy.quote,
        first_name: "#{firstname}",
        last_name: Faker::Name.last_name,
    )
end

5.times do |i|
    Event.create!(
        start_date: Time.now,
        duration: rand(30..160),
        title: "Event n°#{i}",
        description: Faker::TvShows::FamilyGuy.quote,
        price: "#{rand(1..1000)}€",
        location: "Strasbourg",
        admin_id: User.last.id
    )
end
