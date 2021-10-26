class AddUniqueConstraintToUserEventLinks < ActiveRecord::Migration[6.1]
  def change
    remove_index :events_users, %i[event_id user_id]
    add_index :events_users, %i[event_id user_id], unique: true
  end
end
