# frozen_string_literal: true

class AddDuesPaidToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :dues_paid, :boolean, default: false
  end
end
