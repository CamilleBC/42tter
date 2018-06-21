# frozen_string_literal: true

class RemoveRightsInUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :rights
  end
end
