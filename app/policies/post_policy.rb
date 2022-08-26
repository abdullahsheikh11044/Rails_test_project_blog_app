# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def index?
    user_role
  end

  def new?
    user_role
  end

  def show?
    user_role
  end

  def create?
    user_role
  end

  def update?
    user_role
  end

  def edit?
    user_role
  end

  def destroy?
    user_role
  end

  private

  def user_role
    @user.admin? || @user.user?
  end
end
