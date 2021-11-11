# frozen_string_literal: true

class AddForeignKeyBetweenUsersEventsLinkAndEvents < ActiveRecord::Migration[6.1]
  def up
    add_foreign_key :events_users, :events, on_delete: :cascade
  end

  def down
    remove_foreign_key :events_users, column: :event_id
  end
end
