# frozen_string_literal: true

class SessionPolicy
  attr_reader :role

  def initialize(role)
    @role = role
  end

  def create?
    @role == 'guest'
  end

  def destroy?
    @role == 'authorized_user'
  end
end
