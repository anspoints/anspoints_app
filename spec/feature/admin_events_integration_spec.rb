# frozen_string_literal: true

# location: spec/feature/admin_events_integration_spec.rb
require 'rails_helper'

RSpec.describe 'Viewing Events', type: :feature do
  scenario 'valid add event - all fields' do
    date_str = Date.today.to_formatted_s(:long)
    time_str = Time.now.to_formatted_s
    advanced_time_str = Time.now.advance(minutes: 1).to_formatted_s
    visit '/admin/event/new'
    fill_in 'Name', with: 'Greg'
    fill_in 'Eventcode', with: 'abc'
    fill_in 'Description', with: 'testDescription'
    fill_in 'event[date]', with: date_str
    fill_in 'event[startTime]', with: time_str
    fill_in 'event[endTime]', with: advanced_time_str
    click_on 'Save'
    visit '/admin/event'
    expect(page).to have_content('Greg')
    expect(page).to have_content('abc')
    expect(page).to have_content('testDescription')
    expect(page).to have_content(date_str)
    expect(page).to have_content(time_str)
    expect(page).to have_content(advanced_time_str)
  end

  scenario 'valid add event - only required fields' do
    date_str = Date.today.to_formatted_s(:long)
    visit '/admin/event/new'
    fill_in 'Name', with: 'Eta'
    fill_in 'event[date]', with: date_str
    click_on 'Save'
    visit '/admin/event'
    expect(page).to have_content('Eta')
    expect(page).to have_content(date_str)
  end

  scenario 'invalid add event - no name' do
    date_str = Date.today.to_formatted_s(:long)
    visit '/admin/event/new'
    fill_in 'event[date]', with: date_str
    click_on 'Save'
    visit '/admin/event'
    expect(page).not_to have_content(date_str)
  end

  scenario 'invalid add event - no date' do
    visit '/admin/event/new'
    fill_in 'Name', with: 'Aditi'
    click_on 'Save'
    visit '/admin/event'
    expect(page).not_to have_content('Aditi')
  end
end
