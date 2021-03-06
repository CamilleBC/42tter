# frozen_string_literal: true

class AddDefaultValueToActiveInUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :active, :boolean, default: true
  end
end
