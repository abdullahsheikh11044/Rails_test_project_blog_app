# frozen_string_literal: true

class CommentsController < ApplicationController
  def index
    @comment = Comment.all.order('created_at DESC')
  end

  def create
    @post = Post.find_by(id: params[:post_id])
    @comment = @post.comments.new(params_comment)
    if @comment.save
     redirect_to post_path(@post)
    else
     flash[:notice] = @comment.errors.full_messages.to_sentence
    end
  end

  def destroy
    @post = Post.find_by(id: params[:post_id])
    @comment = @post.comments.find_by(id: params[:id])
    flash[:notice] = @comment.errors.full_messages.to_sentence unless @comment.destroy
    redirect_to post_path(@post)
  end

  def show
    @comment = Comment.find_by(id: params[:id])
  end

  def params_comment
    params.require(:comment).permit(:comment, :parent_id, :user_id).with_defaults(user_id: current_user.id)
  end
end
