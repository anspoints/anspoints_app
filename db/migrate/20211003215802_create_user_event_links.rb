# frozen_string_literal: true

class CreateUserEventLinks < ActiveRecord::Migration[6.1]
  def change
    create_table :events_users, id: :uuid do |t|
      t.uuid :event_id
      t.uuid :user_id
      t.index %i[event_id user_id]
      t.timestamps
    end
  end
end
