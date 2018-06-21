# frozen_string_literal: true

class AddActiveInUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :active, :boolean
  end
end
