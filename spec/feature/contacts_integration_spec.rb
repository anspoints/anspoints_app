# frozen_string_literal: true

# location: spec/feature/contacts_integration_spec.rb
require 'rails_helper'

RSpec.describe 'Viewing Contacts', type: :feature do
  scenario 'valid show all' do
    visit contacts_path
    expect(page).to have_content('Test Firstname')
    expect(page).to have_content('Test Lastname')
    expect(page).to have_content('Professor')
    expect(page).to have_content('A genius')
    expect(page).to have_content('Texas A&M')
    expect(page).to have_content('gmoney@gmail.com')
  end

  scenario 'invalid show all' do
    visit contacts_path
    expect(page).not_to have_content('Invalid Firstname')
    expect(page).not_to have_content('Invalid Lastname')
    expect(page).not_to have_content('Teacher')
    expect(page).not_to have_content('A dummy')
    expect(page).not_to have_content('Texas University')
    expect(page).not_to have_content('gbroke@gmail.com')
  end
end
