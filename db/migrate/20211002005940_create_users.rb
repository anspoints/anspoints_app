class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users, id: :uuid do |t|
      t.has_many :userEventLinks
      t.string :netId
      t.string :email
      t.uuid :userDetailsId
      t.boolean :isAdmin
      t.timestamps
    end
  end
end
