# frozen_string_literal: true

class UserPolicy
  attr_reader :user, :id

  def initialize(user, id)
    @user = user
    @id = id
  end

  def index
	admin?
  end

  def deactivate?
    owner_or_admin?
  end

  def edit?
    owner_or_admin?
  end

  def destroy?
	  admin?
  end

  private

  def owner_or_admin?
    @user.role == 'admin' || (@user.role == 'user' && @user.id == @id.to_i)
  end

  def admin?
    @user.role == 'admin'
  end
end
