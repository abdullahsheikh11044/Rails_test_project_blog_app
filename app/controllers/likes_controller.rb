# frozen_string_literal: true

class LikesController < ApplicationController
  def create
    @like = current_user.likes.new(like_params)
    if @like.save
      redirect_back(fallback_location: posts_url)
    else
      flash[:notice] = @like.errors.full_messages.to_sentence
    end
  end

  def destroy
    @like = current_user.likes.find_by(id: params[:id])
    likeable = @like.likeable
    if @like.destroy
      redirect_back(fallback_location: posts_url)
    else
      flash[:notice] = @like.errors.full_messages.to_sentence
    end
  end

  private

  def like_params
    params.require(:like).permit(:likeable_id, :likeable_type)
  end
end
