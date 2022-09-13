# frozen_string_literal: true

module PostsHelper
  def report_count(post)
    post.reports.count.positive?
  end
end
