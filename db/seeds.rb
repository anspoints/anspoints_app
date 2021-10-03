# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# create some events
event = Event.create([{ name: 'Test Event', eventCode: 'TestCode', description: 'lorem ipsum emporium', date: Date.yesterday }]) # event without any time
Event.create([{ name: 'Test Event2', eventCode: 'TestCode', description: 'lorem ipsum emporium', date: Date.tomorrow, startTime: Time.current() }]) # upcoming event
Event.create([{ name: 'Test Event3', eventCode: 'TestCode', description: 'lorem ipsum emporium', date: Date.new(2020, 12, 20), startTime: Time.current() }]) # past event
Event.create([{ name: 'Test Event6', eventCode: 'TestCode', description: 'lorem ipsum emporium', date: Date.new(2021, 11, 24), endTime: Time.current() }]) # upcoming event

# create users
user = User.create([{ name: 'Test user1', isAdmin: false, email: 'testuser@tamu.edu', netId: 'testUser' }])

# create userEventLink
UserEventLink.create([{ user_id: user[0].id, event_id: event[0].id }])


# create a contact
contact = Contact.create([{ firstname: 'Test Firstname', lastname: 'Test Lastname', title: 'Professor', bio: 'A genius', affiliation: 'Texas A&M', email: 'gmoney@gmail.com' }])