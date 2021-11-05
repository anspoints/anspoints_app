# frozen_string_literal: true

# location: spec/feature/admin_contacts_integration_spec.rb
require 'rails_helper'

RSpec.describe 'Adding Contacts', type: :feature do
  scenario 'valid add contact - all fields' do
    visit '/admin/contact/new'
    fill_in 'First name', with: 'Greg'
    fill_in 'Last name', with: 'abc'
    fill_in 'Title', with: 'testTitle'
    fill_in 'Bio', with: 'testBio'
    fill_in 'Affiliation', with: 'testAffiliation'
    fill_in 'contact[email]', with: 'gpetri@tamu.edu'
    click_on 'Save'
    visit '/admin/contact'
    expect(page).to have_content('gpetri@tamu.edu')
    expect(page).to have_content('Greg')
    expect(page).to have_content('abc')
    expect(page).to have_content('testAffiliation')
    expect(page).to have_content('testTitle')
  end

  scenario 'valid add contact - only required fields' do
    visit '/admin/contact/new'
    fill_in 'First name', with: 'Greg2'
    fill_in 'Last name', with: 'abc2'
    fill_in 'contact[email]', with: 'gpetri@tamu.edu'
    click_on 'Save'
    visit '/admin/contact'
    expect(page).to have_content('gpetri@tamu.edu')
    expect(page).to have_content('Greg2')
    expect(page).to have_content('abc2')
  end

  scenario 'invalid add contact - no firstname' do
    visit '/admin/contact/new'
    fill_in 'Last name', with: 'abc3'
    fill_in 'contact[email]', with: 'test@gmail.com'
    click_on 'Save'
    visit '/admin/contact'
    expect(page).not_to have_content('test@gmail.com')
    expect(page).not_to have_content('abc3')
  end

  scenario 'invalid add contact - no lastname' do
    visit '/admin/contact/new'
    fill_in 'First name', with: 'abc3'
    fill_in 'contact[email]', with: 'test@gmail.com'
    click_on 'Save'
    visit '/admin/contact'
    expect(page).not_to have_content('test@gmail.com')
    expect(page).not_to have_content('abc3')
  end

  scenario 'invalid add contact - no email' do
    visit '/admin/contact/new'
    fill_in 'First name', with: 'abc3'
    fill_in 'Last name', with: 'bca'
    click_on 'Save'
    visit '/admin/contact'
    expect(page).not_to have_content('abc3')
    expect(page).not_to have_content('bca')
  end
end

RSpec.describe 'Editing Contacts', type: :feature do
  scenario 'valid edit contact - all fields' do
    firstname = 'Bob'
    lastname = 'Joe'
    title = 'title_'
    bio = 'this is a bio'
    affiliation = 'affiliation baby'
    email = 'test@tamu.edu'
    visit '/admin/contact/new'
    fill_in 'First name', with: firstname
    fill_in 'Last name', with: lastname
    fill_in 'Title', with: title
    fill_in 'Bio', with: bio
    fill_in 'Affiliation', with: affiliation
    fill_in 'contact[email]', with: email
    click_on 'Save'
    visit '/admin/contact'
    expect(page).to have_content(email)
    expect(page).to have_content(firstname)
    expect(page).to have_content(lastname)
    expect(page).to have_content(affiliation)
    expect(page).to have_content(title)
    # check the edit page
    visit '/admin/contact'
    tr = page.find('tr', text: firstname)
    contact_id = tr.find('.id_field').text
    visit "/admin/contact/#{contact_id}/edit"
    expect(page).to have_field('contact[firstname]', with: firstname)
    expect(page).to have_field('contact[lastname]', with: lastname)
    expect(page).to have_field('contact[title]', with: title)
    expect(page).to have_field('contact[bio]', with: bio)
    expect(page).to have_field('contact[email]', with: email)
    expect(page).to have_field('contact[affiliation]', with: affiliation)
    # edit
    new_firstname = 'bobby'
    new_lastname = 'petty'
    new_title = 'titleio'
    new_bio = 'bioibiobioib'
    new_affiliation = 'afiilioi'
    new_email = 'new@gmail.com'
    fill_in 'contact[firstname]', with: new_firstname
    fill_in 'contact[lastname]', with: new_lastname
    fill_in 'contact[title]', with: new_title
    fill_in 'contact[bio]', with: new_bio
    fill_in 'contact[affiliation]', with: new_affiliation
    fill_in 'contact[email]', with: new_email
    click_on 'Save'
    visit '/admin/contact'
    expect(page).to have_content(new_email)
    expect(page).to have_content(new_firstname)
    expect(page).to have_content(new_lastname)
    expect(page).to have_content(new_affiliation)
    expect(page).to have_content(new_title)
    expect(page).not_to have_content(email)
    expect(page).not_to have_content(firstname)
    expect(page).not_to have_content(lastname)
    expect(page).not_to have_content(affiliation)
    expect(page).not_to have_content(title)
  end

  scenario 'valid edit contact - required fields' do
    firstname = 'Bob'
    lastname = 'Joe'
    email = 'test@tamu.edu'
    visit '/admin/contact/new'
    fill_in 'First name', with: firstname
    fill_in 'Last name', with: lastname
    fill_in 'contact[email]', with: email
    click_on 'Save'
    visit '/admin/contact'
    expect(page).to have_content(email)
    expect(page).to have_content(firstname)
    expect(page).to have_content(lastname)
    # check the edit page
    tr = page.find('tr', text: firstname)
    contact_id = tr.find('.id_field').text
    visit "/admin/contact/#{contact_id}/edit"
    expect(page).to have_field('contact[firstname]', with: firstname)
    expect(page).to have_field('contact[lastname]', with: lastname)
    expect(page).to have_field('contact[email]', with: email)
    # edit
    new_firstname = 'bobby'
    new_lastname = 'petty'
    new_title = 'titleio'
    new_bio = 'bioibiobioib'
    new_affiliation = 'afiilioi'
    new_email = 'new@gmail.com'
    fill_in 'contact[firstname]', with: new_firstname
    fill_in 'contact[lastname]', with: new_lastname
    fill_in 'contact[email]', with: new_email
    click_on 'Save'
    visit '/admin/contact'
    expect(page).to have_content(new_email)
    expect(page).to have_content(new_firstname)
    expect(page).to have_content(new_lastname)
    expect(page).not_to have_content(email)
    expect(page).not_to have_content(firstname)
    expect(page).not_to have_content(lastname)
  end

  scenario 'invalid edit contact - no firstname' do
    firstname = 'Bobby'
    lastname = 'Joey'
    email = 'testy@tamu.edu'
    visit '/admin/contact/new'
    fill_in 'First name', with: firstname
    fill_in 'Last name', with: lastname
    fill_in 'contact[email]', with: email
    click_on 'Save'
    visit '/admin/contact'
    expect(page).to have_content(firstname)
    expect(page).to have_content(lastname)
    expect(page).to have_content(email)
    # check the edit page
    tr = page.find('tr', text: firstname)
    contact_id = tr.find('.id_field').text
    visit "/admin/contact/#{contact_id}/edit"
    expect(page).to have_field('contact[firstname]', with: firstname)
    expect(page).to have_field('contact[lastname]', with: lastname)
    expect(page).to have_field('contact[email]', with: email)
    # edit
    new_lastname = 'petty'
    new_email = 'new@gmail.com'
    fill_in 'contact[firstname]', with: ''
    fill_in 'contact[lastname]', with: new_lastname
    fill_in 'contact[email]', with: new_email
    click_on 'Save'
    visit '/admin/contact'
    expect(page).to have_content(email)
    expect(page).to have_content(firstname)
    expect(page).to have_content(lastname)
    expect(page).not_to have_content(new_email)
    expect(page).not_to have_content(new_lastname)
  end

  scenario 'invalid edit contact - no lastname' do
    firstname = 'Bobby'
    lastname = 'Joey'
    email = 'testy@tamu.edu'
    visit '/admin/contact/new'
    fill_in 'First name', with: firstname
    fill_in 'Last name', with: lastname
    fill_in 'contact[email]', with: email
    click_on 'Save'
    visit '/admin/contact'
    expect(page).to have_content(email)
    expect(page).to have_content(firstname)
    expect(page).to have_content(lastname)
    # check the edit page
    tr = page.find('tr', text: firstname)
    contact_id = tr.find('.id_field').text
    visit "/admin/contact/#{contact_id}/edit"
    expect(page).to have_field('contact[firstname]', with: firstname)
    expect(page).to have_field('contact[lastname]', with: lastname)
    expect(page).to have_field('contact[email]', with: email)
    # edit
    new_firstname = 'petty'
    new_email = 'new@gmail.com'
    fill_in 'contact[lastname]', with: ''
    fill_in 'contact[firstname]', with: new_firstname
    fill_in 'contact[email]', with: new_email
    click_on 'Save'
    visit '/admin/contact'
    expect(page).to have_content(email)
    expect(page).to have_content(firstname)
    expect(page).to have_content(lastname)
    expect(page).not_to have_content(new_email)
    expect(page).not_to have_content(new_firstname)
  end

  scenario 'invalid edit contact - no email' do
    firstname = 'Bobby'
    lastname = 'Joey'
    email = 'testy@tamu.edu'
    visit '/admin/contact/new'
    fill_in 'First name', with: firstname
    fill_in 'Last name', with: lastname
    fill_in 'contact[email]', with: email
    click_on 'Save'
    visit '/admin/contact'
    expect(page).to have_content(email)
    expect(page).to have_content(firstname)
    expect(page).to have_content(lastname)
    # check the edit page
    tr = page.find('tr', text: firstname)
    contact_id = tr.find('.id_field').text
    visit "/admin/contact/#{contact_id}/edit"
    expect(page).to have_field('contact[firstname]', with: firstname)
    expect(page).to have_field('contact[lastname]', with: lastname)
    expect(page).to have_field('contact[email]', with: email)
    # edit
    new_firstname = 'petty'
    new_lastname = 'buddy'
    fill_in 'contact[email]', with: ''
    fill_in 'contact[firstname]', with: new_firstname
    fill_in 'contact[lastname]', with: new_lastname
    click_on 'Save'
    visit '/admin/contact'
    expect(page).to have_content(email)
    expect(page).to have_content(firstname)
    expect(page).to have_content(lastname)
    expect(page).not_to have_content(new_firstname)
    expect(page).not_to have_content(new_lastname)
  end
end
