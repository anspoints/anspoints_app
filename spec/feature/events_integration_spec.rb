# frozen_string_literal: true
=begin
# location: spec/feature/events_integration_spec.rb
require 'rails_helper'

RSpec.describe 'Viewing Events', type: :feature do
  scenario 'valid show all' do
    dateStr = Date.today.to_formatted_s(:long)
    visit '/admin/event/new'
    fill_in 'Name', with: 'Eta'
    fill_in 'event[date]', with: dateStr
    click_on 'Save'
    visit events_path
    expect(page).to have_content('Eta')
    expect(page).to have_content(dateStr)
  end
end
=end
