# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def index?
    user_or_admin?
  end
  alias new? index?
  alias show? index?
  alias create? index?
  alias update? index?
  alias edit? index?
  alias destroy? index?

  def user_or_admin?
    @user.user? || @user.admin?
  end
end
