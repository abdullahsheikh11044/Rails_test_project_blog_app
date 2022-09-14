# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @posts = current_user.posts.all
  end
end
