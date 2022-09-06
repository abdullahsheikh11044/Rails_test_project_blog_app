# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def index?
    user_or_moderator?
  end

  def new?
    user?
  end
  alias show? index?
  alias create? new?
  alias update? index?
  alias edit? index?
  alias destroy? index?

  def user_or_moderator?
    @user.user? || @user.moderator?
  end

  def user?
    @user.user?
  end
end
