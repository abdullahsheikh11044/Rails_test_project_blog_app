# frozen_string_literal: true

module PostsHelper
  def report_count_positive(post)
    post.reports.count.positive?
  end
end
