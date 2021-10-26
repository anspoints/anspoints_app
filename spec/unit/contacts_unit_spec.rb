# frozen_string_literal: true

# location: spec/feature/eventsusers_unit_spec.rb
require 'rails_helper'

RSpec.describe Contact, type: :model do
  subject do
    described_class.new(firstname: 'ryan', lastname: 'bill', email: 'ryan@tamu.edu')
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid, missing required values' do
    subject.email = nil
    subject.firstname = nil
    subject.lastname = nil
    expect(subject).not_to be_valid
  end
end
