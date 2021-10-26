# frozen_string_literal: true

# location: spec/feature/eventsusers_unit_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    described_class.new(email: 'ryan@tamu.edu', first_name: "Ryan", last_name: "Surname")
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid, missing required values' do
    old_email = subject.email
    subject.email = nil
    expect(subject).not_to be_valid
    subject.email = old_email

    old_first_name = subject.first_name
    subject.first_name = nil
    expect(subject).not_to be_valid
    subject.first_name = old_first_name

    subject.last_name = nil
    expect(subject).not_to be_valid
  end
end
