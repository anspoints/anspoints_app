# location: spec/feature/admin_users_integration_spec.rb
require 'rails_helper'

RSpec.describe 'Adding Users', type: :feature do
    scenario 'valid add user - all fields' do
        visit '/admin/user/new'
        fill_in 'user[email]', with: 'gcpetri@tamu.edu'
        # find(:css, "#user[isAdmin]").set(true)
        click_on 'Save'
        visit '/admin/user'
        expect(page).to have_content('gcpetri@tamu.edu')
    end

    scenario 'valid add user - all fields' do
        visit '/admin/user/new'
        fill_in 'user[email]', with: 'eta@tamu.edu'
        click_on 'Save'
        visit '/admin/user'
        expect(page).to have_content('eta@tamu.edu')
    end
end