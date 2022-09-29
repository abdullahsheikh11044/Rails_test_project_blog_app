# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @pagy, @posts = pagy(current_user.posts.all)
  end
end
