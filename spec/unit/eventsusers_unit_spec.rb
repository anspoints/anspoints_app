# frozen_string_literal: true

# location: spec/feature/eventsusers_unit_spec.rb
require 'rails_helper'

RSpec.describe 'Creating check-in events', type: :model do
  scenario 'eventsusers rejects non uuids' do
    eventsuser = EventsUsers.new
    eventsuser.event_id = SecureRandom.uuid
    expect(eventsuser.event_id).to_not be_nil
    eventsuser.user_id = 'userbro'
    expect(eventsuser.user_id).to be_nil
    eventsuser.user_id = SecureRandom.uuid
    expect(eventsuser.user_id).to_not be_nil
  end
end
