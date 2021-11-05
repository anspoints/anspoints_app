class AddForeignKeyBetweenEventsAndEventTypes < ActiveRecord::Migration[6.1]
  def change
    add_reference :events, :event_types, type: :uuid, foreign_key: true
  end
end
