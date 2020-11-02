module PointmdComments
  module Aggregators
    class Main
      attr_reader :posts_aggregator, :browser, :comments_aggregator, :all_comments, :posts

      def initialize
        @posts_aggregator    = Aggregators::Posts.new(:news)
        @browser             = ::Watir::Browser.new :chrome, headless: true
        @comments_aggregator = Aggregators::Comments.new
        @all_comments        = []
      end

      def call
        @posts = posts_aggregator.call

        collect_all_comments

        write_to_csv
      end

      private

      def collect_all_comments
        posts.each do |url|
          post_comments = collect_comments_from(url)

          post_comments.each do |c|
            all_comments << ["https://point.md#{url}", c]
          end
        end
      end

      def collect_comments_from(url)
        puts "Collecting comments for #{url}.."

        browser.goto "https://point.md#{url}"
        browser.div(id: 'simpals-comments-list').wait_until(&:present?)

        page = Nokogiri::HTML.parse(browser.html)

        comments_aggregator.call(page)
      end

      def write_to_csv
        CSV.open('output.csv', 'w') do |csv|
          all_comments.each { |c| csv << c }
        end
      end
    end
  end
end
