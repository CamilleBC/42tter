# frozen_string_literal: true

class RemoveParentIdInMessages < ActiveRecord::Migration[5.2]
  def change
    remove_column :messages, :parent_id_id
  end
end
