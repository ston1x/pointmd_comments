module PointmdComments
  module Aggregators
    class Posts
      # NOTE: This array may be populated with other website sections in the future.
      ALLOWED_PLACES = %i[news today].freeze
      MAIN_PAGE      = 'https://point.md/ru/'.freeze

      attr_reader :place, :urls

      def initialize(place)
        @place = place
        @urls = []
      end

      def call
        validate_place
        fetch_posts
        puts "Found #{urls.count} links in the #{place} section.."
        self
      end

      private

      def validate_place
        raise ArgumentError, "Wrong place. Allowed places are #{ALLOWED_PLACES}" unless ALLOWED_PLACES.include?(place)
      end

      def fetch_posts
        @page = download_html
        case place
        when :news
          fetch_news_posts
        when :today
          raise Errors::NotImplemented
        end
      end

      def fetch_news_posts
        posts_block = @page.css('.post-blocks-wrap')
        main_post_heading = posts_block.children.css('.post-big-block').children.css('h2')

        @urls << main_post_heading.children.css('a').first['href']

        other_posts = posts_block.children.css('.post-small-blocks-wrap')

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
