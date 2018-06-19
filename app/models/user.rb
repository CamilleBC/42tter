# frozen_string_literal: true

class User < ApplicationRecord
  EMAIL_REGEXP = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  before_save :encrypt_password, only: %i[create update]
  after_save :clear_password, only: %i[create update]

  attr_accessor :password

  validates :fullname, presence: true, length: { in: 4..150 }
  validates :username, length: { in: 4..20 }
  validates :email, confirmation: true, length: { in: 4..150 }
  validates :email_confirmation, presence: true, length: { in: 4..150 }, on: :create
  validates_format_of :email, with: EMAIL_REGEXP
  validates :password, confirmation: true, length: { in: 8..150 }, on: :create
  validates :password_confirmation, presence: true, length: { in: 4..150 }, on: :create

  has_many :messages

  def self.authenticate(username_or_email = '', login_password = '')
    user = if User.valid_email?(username_or_email)
             User.find_by_email(username_or_email)
           else
             User.find_by_username(username_or_email)
           end
    return nil if user.nil?
    return nil unless user.match_password?(login_password)
    puts user
    user
  end

  def self.valid_email?(email)
    return true if email.match(EMAIL_REGEXP)
    false
  end

  def match_password?(login_password)
    encrypted_password == Digest::SHA1.hexdigest("Adding #{salt} to #{login_password}")
  end

  private

  def clear_password
    self.password = nil
  end

  def delete_user_messages
    messages.all.each(&:delete)
  end

  def encrypt_password
    return unless password.present?
    self.salt = Digest::SHA1.hexdigest("We add #{email} as unique value and #{Time.now} as random value")
    self.encrypted_password = Digest::SHA1.hexdigest("Adding #{salt} to #{password}")
  end
end
