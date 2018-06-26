# frozen_string_literal: true

class User < ApplicationRecord
  EMAIL_REGEXP = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  before_save :encrypt_password, only: %i[create update]
  after_save :clear_password, only: %i[create update]

  attr_accessor :password

  validates :fullname, presence: true, length: { in: 4..150 }
  validates :username, length: { in: 4..20 }, uniqueness: true
  validates :email, confirmation: true, length: { in: 4..150 }, uniqueness: true
  validates :email_confirmation, presence: true, length: { in: 4..150 }, on: :create
  validates_format_of :email, with: EMAIL_REGEXP
  validates :password, confirmation: true, length: { in: 8..150 }, on: :create
  validates :password_confirmation, presence: true, length: { in: 4..150 }, on: :create

  has_many :messages

  def delete_user_messages
    messages.all.each(&:delete)
  end

  def encrypt_password
    return unless password.present?
    self.salt = Digest::SHA1.hexdigest("We add #{email} as unique value and #{Time.now} as random value")
    self.encrypted_password = Digest::SHA1.hexdigest("Adding #{salt} to #{password}")
  end

  private

  def clear_password
    self.password = nil
  end
end
