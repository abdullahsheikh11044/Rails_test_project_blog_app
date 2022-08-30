# frozen_string_literal: true

class SuggestionsController < ApplicationController
  def index
    @post = Post.find_by(id: params[:post_id])
    @suggestion = Suggestion.find_by(id: params[:post_id])
  end

  def create
    @suggestion = current_user.suggestions.new(suggestion_params)
    redirect_to post_path(params[:post_id])
    flash[:notice] = @suggestion.errors.full_messages.to_sentence if @suggestion.save
  end

  def destroy
    @post = Post.find_by(id: params[:post_id])
    @suggestion = @post.suggestions.find_by(id: params[:id])
    flash[:notice] = @suggestion.errors.full_messages.to_sentence unless @suggestion.destroy
    redirect_to post_path(@post)
  end

  private

  def suggestion_params
    params.require(:suggestion).permit(:content, :status, :parent_id,
                                       :user_id).merge(post_id: params[:post_id]).with_defaults(user_id: current_user.id)
  end
end
