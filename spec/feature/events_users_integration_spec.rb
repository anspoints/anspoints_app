# frozen_string_literal: true

# location: spec/feature/usersevents_integration_spec.rb
require 'rails_helper'

RSpec.describe 'Checking In', type: :feature do
  # add event type
  o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
  tag_name = (0...10).map { o[rand(o.length)] }.join
  tag_color = '#AFE1AF'
  before(:each) do
    visit '/admin/event_types/new'
    fill_in 'event_types[name]', with: tag_name
    fill_in 'event_types[pointValue]', with: 4
    fill_in 'event_types[color]', with: tag_color
    click_on 'Save'
  end

  scenario 'can join using event code' do
    date_str = Event.naive_now.to_date.to_formatted_s(:long)
    visit '/admin/event/new'
    fill_in 'Name', with: 'Greg'
    fill_in 'Event code', with: 'abc'
    fill_in 'Description', with: 'testDescription'
    fill_in 'event[date]', with: date_str
    fill_in 'event[eventCode]', with: 'codey'
    select tag_name, from: 'event[event_types_id]'
    click_on 'Save'
    visit events_path
    expect(page).to have_content('Ongoing Events')
    first(:link_or_button, 'Sign In').click  # resolves ambiguity if multiple ongoing events exist in the database
    fill_in 'Enter the meeting code', with: 'codey'
    click_on 'Check In'
    correct_event_join_path = join_event_path(Event.from_code('codey'))
    expect(page).to have_current_path(correct_event_join_path)
    fill_in 'Email:', with: 'sally@tamu.edu'
    fill_in 'First name:', with: 'Sally'
    fill_in 'Last name:', with: 'Hatchet'
    click_on 'Check In'
    expect(page).to have_content('You have signed in successfully. You may now close this page.')
  end

  scenario 'can access qr code' do
    date_str = Event.naive_now.to_date.to_formatted_s(:long)
    visit '/admin/event/new'
    fill_in 'Name', with: 'Greg'
    fill_in 'Event code', with: 'abc'
    fill_in 'Description', with: 'testDescription'
    fill_in 'event[date]', with: date_str
    fill_in 'event[eventCode]', with: 'codey'
    select tag_name, from: 'event[event_types_id]'
    click_on 'Save'
    visit qr_event_path(Event.from_code('codey'))
    expect(page).to have_css('.iframe-within-card')
  end
end
