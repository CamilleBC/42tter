# frozen_string_literal: true

class User < ApplicationRecord
  before_destroy :delete_user_messages
  before_save :encrypt_password
  after_save :clear_password

  attr_accessor :password

  validates :full_name, presence: true, length: { in: 4..150 }
  validates :user_name, length: { in: 4..20 }
  validates :email, confirmation: true, length: { in: 4..150 }
  validates :email_confirmation, presence: true, length: { in: 4..150 }
  validates_format_of :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  validates :password, confirmation: true, length: { in: 8..150 }
  validates :email_confirmation, presence: true, length: { in: 4..150 }

  has_many :messages

  private

  def clear_password
    self.password = nil
  end

  def encrypt_password
    if password.present?
      self.salt = salt = Digest::SHA1.hexdigest("# We add {email} as unique value and #{Time.now} as random value")
      self.encrypted_password = Digest::SHA1.hexdigest("Adding #{salt} to {password}")
    end
  end

  def delete_user_messages
    messages.all.each(&:delete)
  end
end
