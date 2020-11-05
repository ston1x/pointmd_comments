module PointmdComments
  module Aggregators
    class Posts
      # NOTE: This array may be populated with other website sections in the future.
      ALLOWED_SOURCES = %i[news today].freeze
      MAIN_PAGE       = 'https://point.md/ru/'.freeze

      attr_reader :source, :urls

      def initialize(source:, path:)
        @source = source
        @path   = path
        @urls   = []
      end

      def call
        validate_source
        fetch_posts
        puts "Found #{urls.count} links in the #{source} section.."

        @urls
      end

      private

      def validate_source
        return if ALLOWED_SOURCES.include? source

        raise ArgumentError, "Wrong source. Allowed sources are #{ALLOWED_SOURCES}"
      end

      def fetch_posts
        @page = download_html
        case source
        when :news
          fetch_news_posts
        when :today
          raise Errors::NotImplemented
        end
      end

      def fetch_news_posts
        posts_block = @page.css('.post-blocks-wrap')
        main_post_heading = posts_block.children.css('.post-big-block').children.css('h2')

        main_post   = main_post_heading.children.css('a').first['href']
        other_posts = posts_block.children.css('.post-small-blocks-wrap')

        populate_urls(main_post, other_posts)
      end

      def populate_urls(main_post, other_posts)
        @urls << main_post

        @urls += other_posts.children.map do |child|
          child.css('article').css('h2').children[1]['href']
        rescue StandardError
          next
        end.compact
      end

      def download_html
        Nokogiri::HTML(open('https://point.md/ru'))
      end
    end
  end
end
