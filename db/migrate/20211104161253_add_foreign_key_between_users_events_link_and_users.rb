# frozen_string_literal: true

class AddForeignKeyBetweenUsersEventsLinkAndUsers < ActiveRecord::Migration[6.1]
  def up
    add_foreign_key :events_users, :users, on_delete: :cascade
  end

  def down
    remove_foreign_key :events_users, column: :user_id
  end
end
