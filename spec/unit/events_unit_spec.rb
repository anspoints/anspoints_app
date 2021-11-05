# frozen_string_literal: true

# location: spec/feature/eventsusers_unit_spec.rb
require 'rails_helper'

RSpec.describe Event, type: :model do
  before(:each) do
    o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
    tag_name = (0...10).map { o[rand(o.length)] }.join
    event_type = EventTypes.new(name: tag_name, color: '#AFE1AF', pointValue: 1)
    event_type.save
    @event = Event.new(name: 'ryan', eventCode: 'mujit', description: 'test',
                       date: '2021-10-28', startTime: '19:35:00', endTime: '19:50:00',
                       event_types_id: event_type.id)
  end

  it 'is valid with valid attributes' do
    expect(@event).to be_valid
  end

  it 'is not valid, missing required values' do
    @event.name = nil
    @event.date = nil
    @event.startTime = nil
    @event.endTime = nil
    expect(@event).not_to be_valid
  end
end
