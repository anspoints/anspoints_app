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
end
