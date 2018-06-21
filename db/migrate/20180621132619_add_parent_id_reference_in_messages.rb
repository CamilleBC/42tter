# frozen_string_literal: true

class AddParentIdReferenceInMessages < ActiveRecord::Migration[5.2]
  def change
    add_reference :messages, :parent, index: true
  end
end
