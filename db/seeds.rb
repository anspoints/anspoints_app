# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
case Rails.env
when 'development'
  # create and event
  event = Event.create([{ name: 'TestEvent', eventCode: 'TestCode', description: 'lorem ipsum emporium',
                          date: Date.tomorrow, startTime: Time.current }])
  Event.create([{ name: 'Test Event2', eventCode: 'TestCode', description: 'lorem ipsum emporium',
                  date: Date.yesterday, startTime: Time.current }])
  # create a user
  user = User.create([{ isAdmin: false, email: 'testuser@tamu.edu', first_name: 'ANSP_ADMIN',
                        last_name: 'ANSP_ADMIN' }])
  # create an admin user
  admin = User.create([{ isAdmin: true, email: 'adminuser@tamu.edu', first_name: 'ANSP_ADMIN',
                         last_name: 'ANSP_ADMIN' }])
  # create EventsUsers (point tracking)
  EventsUsers.create([{ user_id: user[0].id, event_id: event[0].id }])
  # create a contact
  Contact.create([{ firstname: 'Test Firstname', lastname: 'Test Lastname', title: 'Professor', bio: 'A genius',
                    affiliation: 'Texas A&M', email: 'gmoney@gmail.com' }])
when 'production'
  # master user
  User.find_or_create_by(isAdmin: true, email: 'ans.pointstracker@gmail.com',
                         first_name: 'ANSP_ADMIN', last_name: 'ANSP_ADMIN')
  User.find_or_create_by(isAdmin: true, email: 'americannuclearsociety.tamu@gmail.com',
                         first_name: 'ANSP_ADMIN', last_name: 'ANSP_ADMIN')
  User.find_or_create_by(isAdmin: true, email: 'ans.auditor.123@gmail.com',
                         first_name: 'ANSP_AUDITOR', last_name: 'ANSP_AUDITOR')
end
