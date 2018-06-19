# frozen_string_literal: true

class RenameUserNameToUsernameInUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :user_name, :username
    rename_column :users, :full_name, :fullname
  end
end
