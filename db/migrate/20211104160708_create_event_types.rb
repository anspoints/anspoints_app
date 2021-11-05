class CreateEventTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :event_types, id: :uuid do |t|
      t.string :name
      t.integer :pointValue, default: 1
      t.string :color, default: "#AFE1AF"
      t.timestamps
    end
  end
end
