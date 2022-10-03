# frozen_string_literal: true

class Api::V1::PostsController < ApplicationController
  before_action :find_post, only: %i[show]
  
  def index
    @pagy, @post = pagy(Post.all.order('created_at DESC'))
    render json: @post.map{ |post|
      if post.image.attached?
        post.as_json.merge(image_path: url_for(post.image))
      else
         post.as_json
      end 
    }
  end

  def show    
    if @post.image.attached?
      @post = @post.as_json.merge(image_path: url_for(@post.image))
    end
      render json: @post 
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :status, :user_id, :image)
  end

  def find_post
    @post = Post.find_by(id: params[:id])
    if @post.nil?
      flash[:alert] = 'This post does not exists'
      redirect_to root_path
    end
  end
end
