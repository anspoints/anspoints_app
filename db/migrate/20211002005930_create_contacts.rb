# frozen_string_literal: true

class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts, id: :uuid do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :title
      t.text :bio
      t.string :affiliation
      t.timestamps
    end
  end
end
