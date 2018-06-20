# frozen_string_literal: true

module ApplicationHelper
  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = '42tter'
    page_title.empty? ? base_title : base_title + ' | ' + page_title
  end
end
