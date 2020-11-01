require 'nokogiri'
require 'open-uri'

require 'pointmd_comments/version'
require 'pointmd_comments/aggregators/posts'
require 'pointmd_comments/aggregators/comments'
require 'pointmd_comments/errors/not_implemented'

module PointmdComments
  class Error < StandardError; end

  def collect_comments
    posts   = Aggregators::Posts.new(:news)
    browser = Browser.new :chrome, headless: true
    comments_aggregator = Aggregators::Comments.new

    posts.each do |url|
      browser.goto url
      browser.div(id: 'simpals-comments-list').wait_until_present
      page = Nokogiri::HTML.parse(browser.html)
      comments_aggregator.call(page)
    end
  end
end
