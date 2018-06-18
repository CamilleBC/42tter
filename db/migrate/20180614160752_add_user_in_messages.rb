# frozen_string_literal: true

class AddUserInMessages < ActiveRecord::Migration[5.2]
  def change
    add_reference :messages, :user, foreign_key: true
  end
end
