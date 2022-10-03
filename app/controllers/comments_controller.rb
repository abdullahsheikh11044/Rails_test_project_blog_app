# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :find_post, only: [:create]

  def create
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

  private

  def comment_params
    params.require(:comment).permit(:comment, :parent_id, :user_id, :picture).with_defaults(user_id: current_user.id)
  end

  def find_post
    @post = Post.find_by(id: params[:post_id])
    if @post.nil?
      flash[:alert] = "Post doesn't exist"
    end
  end
end
