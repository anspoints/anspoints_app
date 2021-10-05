class User < ApplicationRecord
    validates :email, presence: true
    validates :isAdmin, inclusion: { in: [ true, false ] }
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 
end