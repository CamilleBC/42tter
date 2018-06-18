# frozen_string_literal: true

class AddEncryptedPasswordAndSaltInUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :encrypted_password, :string
    add_column :users, :salt, :string
  end
end
