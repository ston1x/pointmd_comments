require 'nokogiri'
require 'open-uri'
require 'csv'
require 'watir'

require 'pointmd_comments/version'
require 'pointmd_comments/aggregators/posts'
require 'pointmd_comments/aggregators/comments'
require 'pointmd_comments/errors/not_implemented'

module PointmdComments
  class Error < StandardError; end

  def self.collect
    posts = Aggregators::Posts.new(:news).call.urls
    browser = ::Watir::Browser.new :chrome, headless: true
    comments_aggregator = Aggregators::Comments.new

    all_comments = []
    posts.each do |url|
      browser.goto "https://point.md#{url}"
      browser.div(id: 'simpals-comments-list').wait_until_present
      page = Nokogiri::HTML.parse(browser.html)
      comments = comments_aggregator.call(page)
      comments.each do |c|
        all_comments << ["https://point.md#{url}", c]
      end
    end

    CSV.open('output.csv', 'w') do |csv|
      all_comments.each { |c| csv << c }
    end
  end
end
