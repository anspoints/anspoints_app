# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users, id: :uuid do |t|
      t.string :email
      t.boolean :isAdmin
      t.timestamps
    end
  end
end
