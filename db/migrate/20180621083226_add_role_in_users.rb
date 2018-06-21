# frozen_string_literal: true

class AddRoleInUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :role, :string
  end
end
