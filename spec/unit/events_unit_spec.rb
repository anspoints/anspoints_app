# frozen_string_literal: true

# location: spec/feature/eventsusers_unit_spec.rb
require 'rails_helper'

RSpec.describe Event, type: :model do
  subject do
    described_class.new(name: 'ryan', eventCode: 'mujit', description: 'test',
                        date: '2021-10-28', startTime: '19:35:00', endTime: '19:50:00')
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid, missing required values' do
    subject.name = nil
    subject.date = nil
    subject.startTime = nil
    subject.endTime = nil
    expect(subject).not_to be_valid
  end

  it 'round-trips between naive and real timezones' do
    # Ensure that Event::corrected_time and Event::naive_time are inverse operations
    now = Time.now.in_time_zone('Central Time (US & Canada)')
    round_trip_converted_now = Event.corrected_time Event.naive_time now
    expect(round_trip_converted_now).to eq(now)
  end

  it 'categorizes ongoing events properly' do
    now = Event.naive_now
    today = now.to_date
    event = described_class.create(name: 'Ongoing Event', eventCode: 'X', date: today)
    expect(Event.ongoing).to include(event)
    event.startTime = now - 10.minutes
    expect(Event.ongoing).to include(event)
    event.endTime = now + 10.minutes
    expect(Event.ongoing).to include(event)

    expect(Event.upcoming).not_to include(event)
    expect(Event.past).not_to include(event)
  end

  it 'categorizes upcoming events properly' do
    now = Event.naive_now
    today = now.to_date
    event = described_class.create(name: 'Upcoming Event', eventCode: 'X', date: today, startTime: now + 10.minutes)
    expect(Event.upcoming).to include(event)
    event.endTime = now + 15.minutes
    expect(Event.upcoming).to include(event)

    expect(Event.ongoing).not_to include(event)
    expect(Event.past).not_to include(event)

    event.date = today + 1
    event.startTime = now + 1.day - 15.minutes
    event.startTime = now + 1.day - 10.minutes
    expect(Event.upcoming).to include(event)
  end

  it 'categorizes past events properly' do
    now = Event.naive_now
    today = now.to_date
    event = described_class.create(name: 'Past Event', eventCode: 'X', date: today,
                                   startTime: now - 15.minutes, endTime: now - 10.minutes)
    expect(Event.past).to include(event)

    expect(Event.ongoing).not_to include(event)
    expect(Event.upcoming).not_to include(event)

    event.date = today - 1
    event.startTime = now - 1.day - 10.minutes
    event.endTime = now - 1.day + 10.minutes
    expect(Event.past).to include(event)
  end
end
