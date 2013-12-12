require 'faker'

# rand(15..30).times do
#   password = Faker::Lorem.characters(10)
#   u = User.new(
#     username: Faker::Name.name,
#     email: Faker::Internet.email,
#     password: password,
#     password_confirmation: password)
#   u.skip_confirmation!
#   u.save

#   rand(5..12).times do
#     p = u.pages.create(
#       title: Faker::Lorem.words(rand(1..10)).join(" "), 
#       body: Faker::Lorem.paragraphs(rand(1..4)).join("\n")
#       )
#       # set the created_at to a time within the past year
#     p.update_attribute(:created_at, Time.now - rand(600..31536000))
#     p.set_owner(u)
#   end
# end

user = User.new(
  # username: 'member', 
  email:    'member@example.com', 
  password: 'helloworld',
  password_confirmation: 'helloworld')
# user.skip_confirmation!
user.save

user = User.new(
  # username: 'subscriber', 
  email:    'subscriber@example.com', 
  password: 'helloworld',
  password_confirmation: 'helloworld')
# user.skip_confirmation!
user.save

user = User.new(
  # username: 'test', 
  email:    'test2@example.com', 
  password: 'helloworld',
  password_confirmation: 'helloworld')
# user.skip_confirmation!
user.save


# user = User.new(
#   # username: 'test2', 
#   email:    'test3@example.com', 
#   password: 'helloworld',
#   password_confirmation: 'helloworld')
# # user.skip_confirmation!
# user.save


# list = user.lists.build(name: 'Test Title')
# list.save


# product = list.products.build(name: 'helicopter')
# product.save

puts "Seed finished"
puts "#{User.count} users created"
