# frozen_string_literal: true

class RemoveDisplaynameInUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :displayname
  end
end
