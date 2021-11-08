# frozen_string_literal: true

class Contact < ApplicationRecord
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
    end
  end
end
