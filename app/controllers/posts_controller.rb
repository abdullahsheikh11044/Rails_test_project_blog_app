# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :find_post, only: %i[show update edit destroy]
  
  def index
    @pagy, @post = pagy(Post.all.order('created_at DESC'))
  end

  def new
    @post = Post.new
    authorize @post
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    authorize @post
    if @post.save
      redirect_to @post, flash: { notice: 'Post is successfully  created' }
    else
      render 'new'
      flash[:notice] = @post.errors.full_messages.to_sentence
    end
  end

  def show
    authorize @post
  end

  def update
    authorize @post
    if @post.update(post_params)
      redirect_to @post, flash: { notice: 'Post is successfully  updated' }
    else
      render 'edit'
      flash[:notice] = @post.errors.full_messages.to_sentence
    end
  end

  def edit
    authorize @post
  end

  def destroy
    authorize @post

    if @post.destroy
      redirect_to posts_path, flash: { notice: 'Post is successfully  deleted' }
    else
      flash[:alert] = 'This post does not exists'
    end
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
