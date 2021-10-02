# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
event = Event.create([{ name: 'Test Event', eventCode: 'TestCode', description: 'Lorum Ipsum Imporum', startTime: DateTime.new(2020, 07, 11, 20, 10, 0) }])
contact = Contact.create([{ firstname: 'Greg', lastname: 'Petri', title: 'Professor', bio: 'He is a genius', affiliation: 'Texas A&M', email: 'gmoney@gmail.com' }])