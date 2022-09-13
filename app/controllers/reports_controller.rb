# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :find_post, only: [:create]
  def create
    @report = @post.reports.new(report_params)
    if @report.save
      redirect_to @post, flash: { notice: 'Report is susscessfuly  created' }
    else
      flash[:notice] = @report.errors.full_messages.to_sentence
    end
  end

  private

  def report_params
    params.require(:report).permit(:body, :reportable_id, :reportable_type).with_defaults(user_id: current_user.id)
  end

  def find_post
    @post = Post.find_by(id: params[:post_id])
  end
end
