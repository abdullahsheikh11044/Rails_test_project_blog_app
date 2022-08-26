# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def index?; end

  def new?
    @user.roles == 'user'
  end

  def show?
    @user.roles == 'admin' || 'user'
  end

  def create?
    @user.roles == 'admin' || 'user'
  end

  def update?
    @user.roles == 'admin' || 'user'
  end

  def edit?
    @user.roles == 'admin' || 'user'
  end

  def destroy?
    @user.roles == 'admin' || 'user'
  end
end
