module PointmdComments
  module Aggregators
    class Comments
      attr_reader :result

      def call(page)
        parse_comments(page)
      end

      private

      def parse_comments(page)
        comments = page.css('div#simpals-comments-list').children.first.children
      end
    end
  end
end
