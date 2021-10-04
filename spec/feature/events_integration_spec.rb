# location: spec/feature/events_integration_spec.rb
require 'rails_helper'

RSpec.describe 'Viewing Events', type: :feature do
  scenario 'valid show all' do
    visit events_path
    expect(page).to have_content('Test Event')
    expect(page).to have_content('lorem ipsum emporium')
  end

  scenario 'invalid show all' do
    visit events_path
    expect(page).not_to have_content('Not present event')
    expect(page).not_to have_content('emporium ipsum lorem')
  end
end