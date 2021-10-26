# frozen_string_literal: true

# location: spec/feature/admin_users_integration_spec.rb
require 'rails_helper'

RSpec.describe 'Adding Users', type: :feature do
  scenario 'valid add user - all fields' do
    visit '/admin/user/new'
    fill_in 'user[email]', with: 'gcpetri@tamu.edu'
    fill_in 'user[first_name]', with: 'GC'
    fill_in 'user[last_name]', with: 'Petri'
    # find(:css, "#user[isAdmin]").set(true)
    click_on 'Save'
    visit '/admin/user'
    expect(page).to have_content('gcpetri@tamu.edu')
  end

  scenario 'valid add user - all fields' do
    visit '/admin/user/new'
    fill_in 'user[email]', with: 'syraam@tamu.edu'
    fill_in 'user[first_name]', with: 'Sy'
    fill_in 'user[last_name]', with: 'AM'
    click_on 'Save'
    visit '/admin/user'
    expect(page).to have_content('syraam@tamu.edu')
  end
end
