# frozen_string_literal: true

class AddUnqiueConstrainToEventTypeName < ActiveRecord::Migration[6.1]
  def change
    add_index :event_types, :name, unique: true
  end
end
