=begin
# location: spec/feature/contacts_integration_spec.rb
require 'rails_helper'

RSpec.describe 'Viewing Contacts', type: :feature do
  scenario 'valid show all' do
    visit '/admin/contact/new'
    fill_in 'Firstname', with: 'Greg2'
    fill_in 'Lastname', with: 'abc2'
    click_on 'Save'
    visit contacts_path
    expect(page).to have_content('Greg2')
    expect(page).to have_content('abc2')
  end
end
=end
