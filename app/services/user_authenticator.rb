# frozen_string_literal: true

class UserAuthenticator
  EMAIL_REGEXP = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  def initialize(username_or_email = '')
    @user = if valid_email?(username_or_email)
              User.find_by_email(username_or_email)
            else
              User.find_by_username(username_or_email)
           end
  end

  def authenticate(login_password = '')
    return nil if @user.nil?
    return nil unless match_password?(login_password)
    @user
  end

  def match_password?(login_password)
    @user.encrypted_password == Digest::SHA1.hexdigest("Adding #{@user.salt} to #{login_password}")
  end

  def valid_email?(email)
    return true if email.match(EMAIL_REGEXP)
    false
  end
end
