# frozen_string_literal: true

# location: spec/feature/admin_contacts_integration_spec.rb
require 'rails_helper'

RSpec.describe 'Adding Contacts', type: :feature do
  scenario 'valid add contact - all fields' do
    visit '/admin/contact/new'
    fill_in 'Firstname', with: 'Greg'
    fill_in 'Lastname', with: 'abc'
    fill_in 'Title', with: 'testTitle'
    fill_in 'Bio', with: 'testBio'
    fill_in 'Affiliation', with: 'testAffiliation'
    fill_in 'contact[email]', with: 'gpetri@tamu.edu'
    click_on 'Save'
    visit '/admin/contact'
    expect(page).to have_content('Greg')
    expect(page).to have_content('abc')
    expect(page).to have_content('testTitle')
    expect(page).to have_content('testAffiliation')
  end

  scenario 'valid add contact - only required fields' do
    visit '/admin/contact/new'
    fill_in 'Firstname', with: 'Greg2'
    fill_in 'Lastname', with: 'abc2'
    fill_in 'contact[email]', with: 'gpetri@tamu.edu'
    click_on 'Save'
    visit '/admin/contact'
    expect(page).to have_content('Greg2')
    expect(page).to have_content('abc2')
  end

  scenario 'invalid add contact - no firstname' do
    visit '/admin/contact/new'
    fill_in 'Lastname', with: 'abc3'
    click_on 'Save'
    visit '/admin/contact'
    expect(page).not_to have_content('abc3')
  end

  scenario 'invalid add contact - no lastname' do
    visit '/admin/contact/new'
    fill_in 'Firstname', with: 'abc3'
    click_on 'Save'
    visit '/admin/contact'
    expect(page).not_to have_content('abc3')
  end
end
