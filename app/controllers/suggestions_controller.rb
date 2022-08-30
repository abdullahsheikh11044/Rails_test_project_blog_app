# frozen_string_literal: true

class SuggestionsController < ApplicationController
  def new
    @post = Post.find_by(id: params[:post_id])
    @suggestion = @post.suggestions.new
  end

  def create
    @post = Post.find_by(id: params[:post_id])
    @suggestion = @post.suggestions.new(suggestion_params)
    if @suggestion.save
      redirect_to post_path(params[:post_id])
    else
      flash[:notice] = @suggestion.errors.full_messages.to_sentence
    end
  end

  def destroy
    @suggestion = Suggestion.find_by(id: params[:id])
    post_id = @suggestion.post_id
    if @suggestion.destroy
      redirect_to post_path(post_id)
    else
      flash[:notice] = @suggestion.errors.full_messages.to_sentence
    end
  end

  private

  def suggestion_params
    params.require(:suggestion).permit(:content, :status, :parent_id, :user_id)
                               .with_defaults(user_id: current_user.id)
  end
end
