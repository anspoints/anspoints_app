# frozen_string_literal: true

# location: spec/feature/admin_event_types_integration_spec.rb
require 'rails_helper'

RSpec.describe 'Adding Event Types', type: :feature do
  scenario 'valid add event type' do
    tag_color = '#AFE1AF'
    o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
    tag_name = (0...10).map { o[rand(o.length)] }.join
    # add event type
    visit '/admin/event_types/new'
    fill_in 'event_types[name]', with: tag_name
    fill_in 'event_types[pointValue]', with: 4
    fill_in 'event_types[color]', with: tag_color
    click_on 'Save'
    visit '/admin/event_types'
    # expect(page).to have_content(tag_name)
    # add an event
    date_str = Event.naive_now.to_date.to_formatted_s(:long)
    visit '/admin/event/new'
    fill_in 'Name', with: 'Greg'
    fill_in 'event[date]', with: date_str
    fill_in 'event[eventCode]', with: 'codey'
    select tag_name, from: 'event[event_types_id]'
    click_on 'Save'
    visit '/'
    expect(page).to have_content(tag_name)
    # expect(page).to have_field('.bg-secondary', with: tag_color)
  end
end
