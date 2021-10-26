# frozen_string_literal: true

# location: spec/feature/eventsusers_unit_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    described_class.new(email: 'ryan@tamu.edu')
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid, missing required values' do
    subject.email = nil
    expect(subject).not_to be_valid
  end
end
