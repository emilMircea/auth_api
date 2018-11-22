# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# r db:drop && r db:create && r db:migrate && r db:seed && r s -p 3000

User.create!(
  username: 'bruno',
  email: 'bruno@rottie.com',
  password: 'foobar12'
)

Item.create!(
  name: 'first name', 
  description: 'first description'
)
Item.create!(
  name: 'second name', 
  description: 'second description'
)
