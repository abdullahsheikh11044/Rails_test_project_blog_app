# frozen_string_literal: true

class LikesController < ApplicationController
  def create
    @like = current_user.likes.new(like_params)
    flash[:notice] = @like.errors.full_messages.to_sentence unless @like.save
    redirect_back(fallback_location: posts_url)
  end

  def destroy
    @like = current_user.likes.find_by(id: params[:id])
    likeable = @like.likeable
    flash[:notice] = @like.errors.full_messages.to_sentence unless @like.destroy
    redirect_back(fallback_location: posts_url)
  end

  private

  def like_params
    params.require(:like).permit(:likeable_id, :likeable_type)
  end
end
