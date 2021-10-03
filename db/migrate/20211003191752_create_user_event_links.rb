class CreateUserEventLinks < ActiveRecord::Migration[6.1]
  def change
    create_table :user_event_links, id: :uuid do |t|
      t.belongs_to :event
      t.belongs_to :user
      t.uuid :userId
      t.uuid :eventId
      t.timestamps
    end
  end
end
