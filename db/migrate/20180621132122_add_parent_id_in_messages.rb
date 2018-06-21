# frozen_string_literal: true

class AddParentIdInMessages < ActiveRecord::Migration[5.2]
  def change
    add_reference :messages, :parent_id, index: true
  end
end
