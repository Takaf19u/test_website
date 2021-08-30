module ApplicationHelper
  require "uri"
  def text_url_to_link(text)
    text = safe_join(text.split("\n"), tag(:br))
    URI.extract(text, ["http", "https"]).uniq.each do |url|
      text.gsub!(url, "<a href=\"#{url}\"target=\"_blank\">#{url}</a>")
    end
    text.html_safe
  end
end
