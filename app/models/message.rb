# frozen_string_literal: true

class Message < ApplicationRecord
  validates :body, presence: true, length: { maximum: 150 }

  belongs_to :user
  belongs_to :message
  has_one :message
end
