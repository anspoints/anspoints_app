class EventsUsers < ApplicationRecord
    validates :event_id, presence: true, format: { with: /\A^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$\z/ }
    validates :user_id, presence: true, format: { with: /\A^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$\z/ }
end