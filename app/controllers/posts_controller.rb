# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :find_post, only: %i[show update edit destroy]
  def index
    @post = Post.all.order('created_at DESC')
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
      redirect_to @post
    else
      render 'new'
    end
  end

  def show
    authorize @post
  end

  def update
    authorize @post
    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def edit
    authorize @post
  end

  def destroy
    authorize @post
    flash[:notice] = @post.errors.full_messages.to_sentence unless @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :status, :user_id, :image)
  end

  def find_post
    @post = Post.find_by(id: params[:id])
  end
end
