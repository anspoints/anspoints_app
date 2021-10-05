# location: spec/feature/admin_events_users_integration_spec.rb
require 'rails_helper'
=begin
RSpec.describe 'Adding event users', type: :feature do
    scenario 'valid add user - all fields' do
        visit '/admin/events_user/new'
        fill_in 'events_users[event_id]', with: '3af3e02f-6fe1-4055-b2b3-f1c04fde1763'
        fill_in 'events_users[user_id]', with: '3af3e02f-6fe1-4055-b2b3-f1c04fde1765'
        click_on 'Save'
        visit '/admin/events_user'
        expect(page).to have_content('3af3e02f-6fe1-4055-b2b3-f1c04fde1765')
        expect(page).to have_content('3af3e02f-6fe1-4055-b2b3-f1c04fde1763')
    end

    scenario 'invalid add event user - missing event field' do
        visit '/admin/events_users/new'
        fill_in 'events_users[user_id]', with: '3af3e02f-6fe1-4055-b2b3-f1c04fde1764'
        click_on 'Save'
        visit '/admin/events_user'
        expect(page).not_to have_content('3af3e02f-6fe1-4055-b2b3-f1c04fde1764')
    end

    scenario 'invalid add event user - missing user field' do
        visit '/admin/events_users/new'
        fill_in 'events_users[event_id]', with: '3af3e02f-6fe1-4055-b2b3-f1c04fde1764'
        click_on 'Save'
        visit '/admin/events_user'
        expect(page).not_to have_content('3af3e02f-6fe1-4055-b2b3-f1c04fde1764')
    end

    scenario 'invalid add event user - invalid uuid' do
        visit '/admin/events_users/new'
        fill_in 'events_users[event_id]', with: 'greg'
        fill_in 'events_users[user_id]', with: '3af3e02f-6fe1-4055-b2b3-f1c04fde1768'
        click_on 'Save'
        visit '/admin/events_user'
        expect(page).not_to have_content('greg')
        expect(page).not_to have_content('3af3e02f-6fe1-4055-b2b3-f1c04fde1768')
    end
end
=end