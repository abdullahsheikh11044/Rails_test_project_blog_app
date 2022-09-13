# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @post = current_user.posts.all
  end
end
