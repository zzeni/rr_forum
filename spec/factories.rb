require 'factory_girl'

# sequence used by the Factory.next(:email) method
# Factory.sequence :email do |n|
#   "person-#{n}@example.com"
# end

Factory.sequence :email do |n|
  "person#{n}@example.com" 
end

# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |u|
  u.name                  "Michael Hartl"
  u.email                 "mhartl@example.com"
  u.password              "foobar"
  u.password_confirmation "foobar"
end

Factory.define :post do |p|
  p.content "Foo bar"
  p.association :topic
  p.association :user
end

