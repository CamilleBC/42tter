# frozen_string_literal: true

class RenameDisplayNameToDisplaynameInUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :display_name, :displayname
  end
end
