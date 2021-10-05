# location: spec/feature/admin_events_integration_spec.rb
require 'rails_helper'

RSpec.describe 'Adding Events', type: :feature do
    scenario 'valid add event - all fields' do
        dateStr = Date.today.to_formatted_s(:long)
        timeStr = Time.now.to_formatted_s()
        advancedTimeStr = Time.now.advance(minutes: 1).to_formatted_s()
        visit '/admin/event/new'
        fill_in 'Name', with: 'Greg'
        fill_in 'Eventcode', with: 'abc'
        fill_in 'Description', with: 'testdescription'
        fill_in 'event[date]', with: dateStr
        fill_in 'event[startTime]', with: timeStr
        fill_in 'event[endTime]', with: advancedTimeStr
        click_on 'Save'
        visit '/admin/event'
        expect(page).to have_content('Greg')
        expect(page).to have_content('abc')
        expect(page).to have_content('testdescription')
        expect(page).to have_content(dateStr)
    end

    scenario 'valid add event - only required fields' do
        dateStr = Date.today.to_formatted_s(:long)
        visit '/admin/event/new'
        fill_in 'Name', with: 'Eta'
        fill_in 'event[date]', with: dateStr
        click_on 'Save'
        visit '/admin/event'
        expect(page).to have_content('Eta')
        expect(page).to have_content(dateStr)
    end

    scenario 'invalid add event - no name' do
        dateStr = Date.today.to_formatted_s(:long)
        visit '/admin/event/new'
        fill_in 'event[date]', with: dateStr
        click_on 'Save'
        visit '/admin/event'
        expect(page).not_to have_content(dateStr)
    end

    scenario 'invalid add event - no date' do
        visit '/admin/event/new'
        fill_in 'Name', with: 'Aditi'
        click_on 'Save'
        visit '/admin/event'
        expect(page).not_to have_content('Aditi')
    end
end
