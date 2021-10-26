# frozen_string_literal: true

# location: spec/feature/eventsusers_unit_spec.rb
require 'rails_helper'

RSpec.describe 'Creating check-in events', type: :model do
  scenario 'EventsUsers rejects non uuids' do
    events_user = EventsUsers.new
    events_user.event_id = SecureRandom.uuid
    expect(events_user.event_id).to_not be_nil
    events_user.user_id = 'userBro'
    expect(events_user.user_id).to be_nil
    events_user.user_id = SecureRandom.uuid
    expect(events_user.user_id).to_not be_nil
  end
end
