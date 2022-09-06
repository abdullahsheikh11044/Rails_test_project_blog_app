# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @user = User.find_by(id: params[:id])
    @post = Post.all
  end
end
