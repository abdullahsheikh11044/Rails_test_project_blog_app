# frozen_string_literal: true

class ReportsController < ApplicationController
  def create
    @post = Post.find_by(id: params[:post_id])
    @report = @post.reports.new(report_params)
    if @report.save
      redirect_to @post
    else
      flash[:notice] = @report.errors.full_messages.to_sentence
    end
  end

  private

  def report_params
    params.require(:report).permit(:body, :post_id).with_defaults(user_id: current_user.id)
  end
end
