# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user1 = User.create!(
    name: "Abdullah",
    email: "zunairaijaz2018@gmail.com",
    password: "12345678",
    role: 0,
)
Post.create([{
    title: "First Post",
    body: "Hello world!",
    status: 0,
    user_id: user1.id,
  },
  {
    title: "First Post",
    body: "Hello world!",
    status: 0,
    user_id: user1.id,
  },
  {
    title: "First Post",
    body: "Hello world!",
    status: 0,
    user_id: user1.id,
  }])
  
