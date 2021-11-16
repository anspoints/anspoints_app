# frozen_string_literal: true

# location: spec/feature/admin_points_integration_spec.rb
require 'rails_helper'

RSpec.describe 'Admin points view functionality', type: :feature do
  # add event type
  o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
  tag_name = (0...10).map { o[rand(o.length)] }.join
  tag_color = '#AFE1AF'
  before(:all) do
    visit '/admin/event_types/new'
    fill_in 'event_types[name]', with: tag_name
    fill_in 'event_types[pointValue]', with: 4
    fill_in 'event_types[color]', with: tag_color
    click_on 'Save'
  end

  scenario 'can view point totals by user' do
    date_str = Event.naive_now.to_date.to_formatted_s(:long)
    visit '/admin/event/new'
    fill_in 'Name', with: 'Random'
    fill_in 'Event code', with: 'abc'
    fill_in 'Description', with: 'testDescription'
    fill_in 'event[date]', with: date_str
    fill_in 'event[eventCode]', with: 'password'
    select tag_name, from: 'event[event_types_id]'
    click_on 'Save'
    visit '/admin/user/new'
    fill_in 'user[email]', with: 'batman@tamu.edu'
    fill_in 'user[first_name]', with: 'Bruce'
    fill_in 'user[last_name]', with: 'Wayne'
    click_on 'Save'
    visit events_path
    expect(page).to have_content('Ongoing Events')
    first(:link_or_button, 'Sign In').click  # resolves ambiguity if multiple ongoing events exist in the database
    fill_in 'Enter the meeting code', with: 'password'
    click_on 'Check In'
    correct_event_join_path = join_event_path(Event.from_code('password'))
    expect(page).to have_current_path(correct_event_join_path)
    fill_in 'Email:', with: 'batman@tamu.edu'
    fill_in 'First name:', with: 'Bruce'
    fill_in 'Last name:', with: 'Wayne'
    click_on 'Check In'
    expect(page).to have_content('You have signed in successfully. You may now close this page.')
    visit '/points'
    expect(page).to have_content('batman@tamu.edu')
    visit events_path
    expect(page).to have_content('Ongoing Events')
    first(:link_or_button, 'Join').click  # resolves ambiguity if multiple ongoing events exist in the database
    fill_in 'Enter the meeting code', with: 'password'
    click_on 'Check In'
    correct_event_join_path = join_event_path(Event.from_code('password'))
    expect(page).to have_current_path(correct_event_join_path)
    fill_in 'Email:', with: 'superman@tamu.edu'
    fill_in 'First name:', with: 'Clark'
    fill_in 'Last name:', with: 'Kent'
    click_on 'Check In'
    expect(page).to have_content('You have signed in successfully. You may now close this page.')
    visit '/points'
    expect(page).to have_content('superman@tamu.edu')
    expect(page).to have_content('batman@tamu.edu')
    expect(page).to have_content('4') # points validation
  end
end
