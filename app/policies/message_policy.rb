# frozen_string_literal: true

class MessagePolicy
  attr_reader :user, :id

  def initialize(user, id)
    @user = user
    @id = id
  end

  def deactivate?
    @user.role == ('user' || 'admin') && @user.id == @id.to_i
  end

  def destroy?
    @user.role == 'admin'
  end
end
