# frozen_string_literal: true

class CommentsController < ApplicationController
  def index
    @comment = Comment.all.order('created_at DESC')
  end

  def create
    @post = Post.find_by(id: params[:post_id])
    @comment = @post.comments.new(comment_params)
    if @comment.save
      respond_to do |format|
        format.html { redirect_to post_path(@post) }
        format.js { render 'create.js.erb' }
      end
    else
      flash[:notice] = @comment.errors.full_messages.to_sentence
    end
  end

  def show
    @comment = Comment.find_by(id: params[:id])
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :parent_id, :user_id, :picture).with_defaults(user_id: current_user.id)
  end
end
