class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events, id: :uuid do |t|
      t.string :name
      t.string :eventCode
      t.uuid :eventTypeId
      t.string :description
      t.datetime :startTime
      t.datetime :endTime
      t.timestamps
    end
  end
end
