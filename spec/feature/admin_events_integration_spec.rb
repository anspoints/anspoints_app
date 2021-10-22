# frozen_string_literal: true

# location: spec/feature/admin_events_integration_spec.rb
require 'rails_helper'

RSpec.describe 'Editing Events', type: :feature do
  scenario 'valid edit event - all fields' do
    # add an event first
    date_str = Date.today.to_formatted_s(:long)
    time_str = Time.now.to_formatted_s
    #trimmed_time_str = Time.parse(time_str).strftime('%H:%M')
    advanced_time_str = Time.now.advance(minutes: 1).to_formatted_s
    #trimmed_advanced_time_str = Time.parse(advanced_time_str).strftime('%H:%M')
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
    #expect(page).to have_content(trimmed_time_str)
    #expect(page).to have_content(trimmed_advanced_time_str)
    # test the edit page
    tr = page.find('tr', text: 'Greg')
    eventId = tr.find('.id_field').text
    # eventId = page.find(:xpath, '//*[@id="bulk_form"]/table/tbody/tr/td[2]').title
    visit '/admin/event/' + eventId + '/edit'
    expect(page).to have_field('event[name]', with: 'Greg')
    expect(page).to have_field('event[eventCode]', with: 'abc')
    expect(page).to have_field('event[description]', with: 'testDescription')
    expect(page).to have_field('event[date]', with: date_str)
    #expect(page).to have_field('event[startTime]', with: time_str)
    #expect(page).to have_field('event[endTime]', with: advanced_time_str)
    # edit everything
    new_date_str = Date.tomorrow.to_formatted_s(:long)
    new_time_str = Time.now.to_formatted_s
    #trimmed_new_time_str = Time.parse(new_time_str).strftime('%H:%M')
    new_advanced_time_str = Time.now.advance(minutes: 1).to_formatted_s
    #trimmed_new_advanced_time_str = Time.parse(new_advanced_time_str).strftime('%H:%M')
    fill_in 'Name', with: 'Danny'
    fill_in 'Eventcode', with: 'cba'
    fill_in 'Description', with: 'descriptionTest'
    fill_in 'event[date]', with: new_date_str
    fill_in 'event[startTime]', with: new_time_str
    fill_in 'event[endTime]', with: new_advanced_time_str
    click_on 'Save'
    # verify all the info updated
    visit '/admin/event'
    expect(page).to have_content('Danny')
    expect(page).to have_content('cba')
    expect(page).to have_content('descriptionTest')
    expect(page).to have_content(new_date_str)
    #expect(page).to have_content(trimmed_new_time_str)
    #expect(page).to have_content(trimmed_new_advanced_time_str)
  end

  scenario 'valid edit event - some fields' do
    # add an event first
    date_str = Date.today.to_formatted_s(:long)
    time_str = Time.now.to_formatted_s
    #trimmed_time_str = Time.parse(time_str).strftime('%H:%M')
    advanced_time_str = Time.now.advance(minutes: 1).to_formatted_s
    #trimmed_advanced_time_str = Time.parse(advanced_time_str).strftime('%H:%M')
    visit '/admin/event/new'
    fill_in 'Name', with: 'Buddy'
    fill_in 'Eventcode', with: 'abcd'
    fill_in 'Description', with: 'testDescription'
    fill_in 'event[date]', with: date_str
    fill_in 'event[startTime]', with: time_str
    fill_in 'event[endTime]', with: advanced_time_str
    click_on 'Save'
    visit '/admin/event'
    expect(page).to have_content('Buddy')
    expect(page).to have_content('abcd')
    expect(page).to have_content('testDescription')
    expect(page).to have_content(date_str)
    #expect(page).to have_content(trimmed_time_str)
    #expect(page).to have_content(trimmed_advanced_time_str)
    # test the edit page
    tr = page.find('tr', text: 'Buddy')
    eventId = tr.find('.id_field').text
    # eventId = page.find(:xpath, '//*[@id="bulk_form"]/table/tbody/tr/td[2]').title
    visit '/admin/event/' + eventId + '/edit'
    expect(page).to have_field('event[name]', with: 'Buddy')
    expect(page).to have_field('event[eventCode]', with: 'abcd')
    expect(page).to have_field('event[description]', with: 'testDescription')
    expect(page).to have_field('event[date]', with: date_str)
    #expect(page).to have_field('event[startTime]', with: time_str)
    #expect(page).to have_field('event[endTime]', with: advanced_time_str)
    # edit description
    fill_in 'Eventcode', with: 'cbad___'
    click_on 'Save'
    # verify all the info updated
    visit '/admin/event'
    expect(page).to have_content('Buddy')
    expect(page).to have_content('cbad___')
    expect(page).to have_content('testDescription')
    expect(page).to have_content(date_str)
  end
end

RSpec.describe 'Adding Events', type: :feature do
  scenario 'valid add event - all fields' do
    date_str = Date.today.to_formatted_s(:long)
    time_str = Time.now.to_formatted_s
    #trimmed_time_str = Time.parse(time_str).strftime('%H:%M')
    advanced_time_str = Time.now.advance(minutes: 1).to_formatted_s
    #trimmed_advanced_time_str = Time.parse(advanced_time_str).strftime('%H:%M')
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
    #expect(page).to have_content(trimmed_time_str)
    #expect(page).to have_content(trimmed_advanced_time_str)
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

RSpec.describe 'Reviewing Events', type: :feature do
  scenario 'check that event can be viewed to user' do
    date_str = Date.today.to_formatted_s(:long)
    time_str = Time.now.to_formatted_s
    advanced_time_str = Time.now.advance(minutes: 1).to_formatted_s
    visit '/admin/event/new'
    fill_in 'Name', with: 'Derek'
    fill_in 'Eventcode', with: 'abc'
    fill_in 'Description', with: 'testDescription'
    fill_in 'event[date]', with: date_str
    fill_in 'event[startTime]', with: time_str
    fill_in 'event[endTime]', with: advanced_time_str
    click_on 'Save'
    visit '/admin/event'
    expect(page).to have_content('Derek')
    expect(page).to have_content('abc')
    expect(page).to have_content('testDescription')
    expect(page).to have_content(date_str)
    visit '/'
    expect(page).to have_content('Derek')
    expect(page).not_to have_content('abc')
    expect(page).to have_content('testDescription')
  end
end

RSpec.describe 'Deleting Events', type: :feature do
  scenario 'remove an event successfully' do
    date_str = Date.today.to_formatted_s(:long)
    time_str = Time.now.to_formatted_s
    advanced_time_str = Time.now.advance(minutes: 1).to_formatted_s
    visit '/admin/event/new'
    fill_in 'Name', with: 'Betty'
    fill_in 'Eventcode', with: 'bettycode'
    fill_in 'Description', with: 'bettyDescription'
    fill_in 'event[date]', with: date_str
    fill_in 'event[startTime]', with: time_str
    fill_in 'event[endTime]', with: advanced_time_str
    click_on 'Save'
    visit '/admin/event'
    expect(page).to have_content('Betty')
    expect(page).to have_content('bettycode')
    expect(page).to have_content('bettyDescription')
    expect(page).to have_content(date_str)
    tr = page.find('tr', text: 'Betty')
    eventId = tr.find('.id_field').text
    visit '/admin/event/' + eventId + '/delete'
    click_on "Yes, I'm sure"
    visit '/admin/event'
    expect(page).not_to have_content('Betty')
    expect(page).not_to have_content('bettycode')
    expect(page).not_to have_content('bettyDescription')
  end

  scenario 'remove an event successfully' do
    date_str = Date.today.to_formatted_s(:long)
    time_str = Time.now.to_formatted_s
    advanced_time_str = Time.now.advance(minutes: 1).to_formatted_s
    visit '/admin/event/new'
    fill_in 'Name', with: 'Bobby'
    fill_in 'Eventcode', with: 'bobbycode'
    fill_in 'Description', with: 'bobbyDescription'
    fill_in 'event[date]', with: date_str
    fill_in 'event[startTime]', with: time_str
    fill_in 'event[endTime]', with: advanced_time_str
    click_on 'Save'
    visit '/admin/event'
    expect(page).to have_content('Bobby')
    expect(page).to have_content('bobbycode')
    expect(page).to have_content('bobbyDescription')
    expect(page).to have_content(date_str)
    tr = page.find('tr', text: 'Bobby')
    eventId = tr.find('.id_field').text
    visit '/admin/event/' + eventId + '/delete'
    click_on "Cancel"
    visit '/admin/event'
    expect(page).to have_content('Bobby')
    expect(page).to have_content('bobbycode')
    expect(page).to have_content('bobbyDescription')
    expect(page).to have_content(date_str)
  end
end