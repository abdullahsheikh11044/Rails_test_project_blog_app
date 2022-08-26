# frozen_string_literal: true

class LikesController < ApplicationController
  def create
    @like = current_user.likes.new(like_params)
    if !@like.save
      flash[:notice] = @like.errors.full_messages.to_sentence
    else
      redirect_back(fallback_location: posts_url)
    end
  end

  def destroy
    @like = current_user.likes.find_by(id: params[:id])
    likeable = @like.likeable
    if !@like.destroy
      flash[:notice] = @like.errors.full_messages.to_sentence
    else
      redirect_back(fallback_location: posts_url)
    end
  end

  private

  def like_params
    params.require(:like).permit(:likeable_id, :likeable_type)
  end
end
