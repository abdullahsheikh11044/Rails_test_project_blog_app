# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def index?
    user?
  end
  alias create? index?
  alias destroy? index?
  alias update? index?
  alias show? index?

  def user?
    @user.user?
  end
end
