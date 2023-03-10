# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

customer1 = Customer.create!(first_name: "Stephen", last_name: "Fabian", email: "fabianstephen@gmail.com", address: "1882 Blue Ct, Denver CO 80654")
customer2 = Customer.create!(first_name: "Tommy", last_name: "Jones", email: "fabiant@gmail.com", address: "1111 Blue Ct, Denver CO 80654")
customer3 = Customer.create!(first_name: "Katie", last_name: "Williams", email: "fabiank@gmail.com", address: "2222 Blue Ct, Denver CO 80654")

subscription1 = customer1.subscriptions.create!(title: "Premium Subscription", price: 50)
subscription2 = customer2.subscriptions.create!(title: "Medium Subscription", price: 20)
subscription3 = customer2.subscriptions.create!(title: "Basic Subscription", price: 10)
subscription4 = Subscription.create!(title: "Cheap Subscription", price: 5)

subscription1.teas.create!(title: "Black Tea", description: "super great and organic", temperature: 100, brew_time: 30)
subscription1.teas.create!(title: "Green Tea", description: "super great and grass fed", temperature: 90, brew_time: 35)
subscription1.teas.create!(title: "Orange Tea", description: "it's orange", temperature: 70, brew_time: 36)

