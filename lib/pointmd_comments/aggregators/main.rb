module PointmdComments
  module Aggregators
    class Main
      CHROME_ARGS =  %w[disable-dev-shm-usage disable-software-rasterizer no-sandbox].freeze

      attr_reader :posts_aggregator, :browser, :comments_aggregator, :all_comments, :posts, :source, :output, :path

      def initialize(options)
        # Currently 'path' is not supported
        @path                = nil
        @output              = options[:output] || default_output_path
        @source              = options[:source] || Aggregators::Posts::DEFAULT_SOURCE
        @posts_aggregator    = Aggregators::Posts.new(source: source, path: path)
        @comments_aggregator = Aggregators::Comments.new

        client = Selenium::WebDriver::Remote::Http::Default.new
        # NOTE: #timeout= is deprecated, use #read_timeout= and #open_timeout= instead
        client.timeout = 600 # instead of the default 60 (seconds)

        @browser             = ::Watir::Browser.new :chrome, http_client: client, headless: true, args: CHROME_ARGS
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
        # File#expand_path is needed to process paths like '~/test.txt' => '/Users/me/test.txt'
        file_path = File.expand_path(output)
        puts "File Path is #{file_path}"

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
