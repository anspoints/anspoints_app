# frozen_string_literal: true

class Contact < ApplicationRecord
  attribute :affiliation, :string
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  def self.search(search)
    if search
      name = Contact.find_by(lastname: search)
      if
        self.where(Contact.lastname: name)
      else
        @Contacts = Contact.all
      end
    else
      @Contacts = Contact.all
  def name
    "#{firstname} #{lastname}"
  end

  rails_admin do
    configure :firstname do
      label 'First name'
    end

    configure :lastname do
      label 'Last name'
    end

    list do
      configure :name do
        formatted_value { bindings[:object].name }
        read_only true
        help ''
      end
      fields :id, :email, :name, :affiliation, :title
    end
  end
end
