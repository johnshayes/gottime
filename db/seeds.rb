# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# encoding: utf-8

user = User.create(first_name: "Moritz", last_name: "Wahrlich", password: "testtest")

user_list = [
  {
  first_name: "Jay",
  last_name: "Z",
  email: "jayz@rappers.com",
  password: "testtest"
  },
  {
  first_name: "DJ",
  last_name: "Khaled",
  email: "djkhaled@rappers.com",
  password: "testtest"
  },
  {
  first_name: "Notorious",
  last_name: "BIG",
  email: "notoriousbig@rappers.com",
  password: "testtest"
  },
  {
  first_name: "J.",
  last_name: "Cole",
  email: "jcoleg@rappers.com",
  password: "testtest"
  },
  {
  first_name: "50",
  last_name: "Cent",
  email: "50cent@rappers.com",
  password: "testtest"
  },
  {
  first_name: "Big",
  last_name: "Punisher",
  email: "bigpunisher@rappers.com",
  password: "testtest"
  },
  {
  first_name: "Snoop",
  last_name: "Dogg",
  email: "snoopdogg@rappers.com",
  password: "testtest"
  },
]

user_list.each do |parameters|
  User.create(parameters)
end

listings_content = [
{
  activity: "🤷",
  location: "Berlin",
  comment: "Fuck bitches get money",
  offered_datetime_text: "Now"
  }]

User.all.each do |user|
  listings_content.each do |listing_params|
    l = Listing.new(listing_params)
    l.user = user
    l.save!
  end

  user.save!
end
