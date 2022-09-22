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
  def update?
    if @user.moderator?     
      true 
    else
      @user.user? && (@user == @post.user)
    end
  end
  def edit?
    if @user.moderator?     
      true 
    else
      @user.user? && (@user == @post.user)
    end
  end
  def destroy?
    if @user.moderator?
      true
    else
      @user.user? && (@user == @post.user)
    end
  end

  def user_or_moderator?
    @user.user? || @user.moderator?
  end

  def user?
    @user.user?
  end
end
