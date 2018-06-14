# frozen_string_literal: true

class User < ApplicationRecord
  validates :full_name, presence: true, length: { in: 4..150 }
  validates :user_name, length: { in: 4..20 }
  validates :email, confirmation: true, length: { in: 4..150 }
  validates :email_confirmation, presence: true, length: { in: 4..150 }
  validates_format_of :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
end
