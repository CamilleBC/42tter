# frozen_string_literal: true

class AddUserNameInUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :user_name, :string
    add_column :users, :rights, :string
  end
end
