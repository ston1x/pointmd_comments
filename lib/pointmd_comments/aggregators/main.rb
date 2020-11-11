module PointmdComments
  module Aggregators
    class Main
      attr_reader :posts_aggregator, :browser, :comments_aggregator, :all_comments, :posts, :source, :output, :path

      def initialize(options)
        # Currently 'path' is not supported
        @path                = nil
        @output              = options[:output]
        @source              = options[:source]
        @posts_aggregator    = Aggregators::Posts.new(source: source, path: path)
        @comments_aggregator = Aggregators::Comments.new
        @browser             = ::Watir::Browser.new :chrome, headless: true
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
        file_path = output || default_output_path

        CSV.open(file_path, 'w') do |csv|
          all_comments.each { |c| csv << c }
        end
      end

      def default_output_path
        "pointmd_comments_#{current_time}.csv"
      end

      def current_time
        Time.now.strftime('%Y%m%d_%H%M')
      end
    end
  end
end
