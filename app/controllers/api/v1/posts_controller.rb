# frozen_string_literal: true

class Api::V1::PostsController < ApplicationController
  before_action :find_post, only: %i[show]
  
  def index
    @pagy, @post = pagy(Post.all.order('created_at DESC'))
    render json: @post
  end

  def show    
      render json: @post 
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :status, :user_id, :image)
  end

  def find_post
    @post = Post.find_by(id: params[:id])
    if @post.blank?
      render json: {status: "error"}
    end
  end
end
