# frozen_string_literal: true

class Message < ApplicationRecord
  validates :body, presence: true, length: { maximum: 150 }

  belongs_to :user
  has_one :message, class_name: 'Message', foreign_key: 'parent_id'

  def hide
    self.body = 'message deleted by user'
    save
  end
end
