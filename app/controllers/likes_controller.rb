# frozen_string_literal: true

class LikesController < ApplicationController
  def create
    @like = current_user.likes.new(like_params)
    @likeable = if @like.likeable_type == 'Post'
                  Post.find(@like.likeable_id)
                else
                  Comment.find(@like.likeable_id)
                end
    @like.save!
  end

  def destroy
    @like = current_user.likes.find_by(id: params[:id])
    likeable = @like.likeable
    @likeable = if @like.likeable_type == 'Post'
                  Post.find(@like.likeable_id)
                else
                  Comment.find(@like.likeable_id)
                end
    @like.destroy!
  end

  private

  def like_params
    params.require(:like).permit(:likeable_id, :likeable_type)
  end
end
