# frozen_string_literal: true

# location: spec/feature/usersevents_integration_spec.rb
require 'rails_helper'

RSpec.describe 'Checking In', type: :feature do
  scenario 'can join using event code' do
    date_str = Date.today.to_formatted_s(:long)
    visit '/admin/event/new'
    fill_in 'Name', with: 'Greg'
    fill_in 'Eventcode', with: 'abc'
    fill_in 'Description', with: 'testDescription'
    fill_in 'event[date]', with: date_str
    fill_in 'event[eventCode]', with: 'codey'
    click_on 'Save'
    visit events_path
    expect(page).to have_content('Upcoming Events')
    click_on 'Join'
    fill_in 'Enter the meeting code', with: 'codey'
    click_on 'Check In'
    correct_event_join_path = join_event_path(Event.find_by(eventCode: 'codey'))
    expect(page).to have_current_path(correct_event_join_path)
    fill_in 'Email:', with: 'guy@fieri.com'
    click_on 'Check In'
    expect(page).to have_content('You have signed in successfully. You may now close this page.')
  end

  scenario 'can access qr code' do
    date_str = Date.today.to_formatted_s(:long)
    visit '/admin/event/new'
    fill_in 'Name', with: 'Greg'
    fill_in 'Eventcode', with: 'abc'
    fill_in 'Description', with: 'testDescription'
    fill_in 'event[date]', with: date_str
    fill_in 'event[eventCode]', with: 'codey'
    click_on 'Save'
    visit qr_event_path(Event.find_by(eventCode: 'codey'))
    expect(page).to have_css('.iframe-within-card')
  end
end
