module ApplicationHelper
  require "uri"
  def text_url_to_link(text)

    URI.extract(text, ["http", "https"]).uniq.each do |url|
      text.gsub!(url, "#{url}")
    end
    text
  end
end
