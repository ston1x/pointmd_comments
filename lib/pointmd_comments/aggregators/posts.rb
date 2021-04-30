module PointmdComments
  module Aggregators
    class Posts
      # NOTE: This array may be populated with other website sections in the future.
      ALLOWED_SOURCES = %i[news today].freeze
      DEFAULT_SOURCE  = :news
      MAIN_PAGE       = 'https://point.md/ru/'.freeze

      attr_reader :source, :urls

      def initialize(source:, path:)
        @source = source
        @path   = path
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
        # NOTE: .post-blocks-wrap does not exist anymore
        # Find <article> tags instead
        articles = @page.css('article')

        @urls = articles.map do |article|
          article.css('a').last.attribute('href').to_s
        rescue StandardError => e
          puts e
        end.compact
      end

      def download_html
        Nokogiri::HTML(open('https://point.md/ru'))
      end
    end
  end
end
