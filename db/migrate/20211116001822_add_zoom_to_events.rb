# frozen_string_literal: true

class AddZoomToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :zoom, :string
  end
end
