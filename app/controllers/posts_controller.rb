# frozen_string_literal: true

class PostsController < ApplicationController
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
    if @post.save
      redirect_to @post
    else
      render 'new'
    end
    authorize @post
  end

  def show
    @post = Post.find_by(id: params[:id])
    authorize @post
  end

  def update
    @post = Post.find_by(id: params[:id])
    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
    authorize @post
  end

  def edit
    @post = Post.find_by(id: params[:id])
    authorize @post
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    flash[:notice] = @post.errors.full_messages.to_sentence unless @post.destroy
    redirect_to posts_path
    authorize @post
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :status, :user_id)
  end
end
