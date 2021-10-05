# frozen_string_literal: true

# location: spec/feature/usersevents_integration_spec.rb
require 'rails_helper'

RSpec.describe 'Checking In', type: :feature do
  scenario 'can join using event code' do
    visit events_path
    expect(page).to have_content('Join')
    click_on 'Join'
    fill_in 'Enter the meeting code', with: 'TestCode'
    click_on 'Check In'
    correct_event_join_path = join_event_path(Event.find_by(eventCode: 'TestCode'))
    expect(page).to have_current_path(correct_event_join_path)
    fill_in 'Email:', with: 'guy@fieri.com'
    click_on 'Check In'
    expect(page).to have_content('You have signed in successfully. You may now close this page.')
  end

  scenario 'can access qr code' do
    visit qr_event_path(Event.find_by(eventCode: 'TestCode'))
    expect(page).to have_css('.iframe-within-card')
  end
end
