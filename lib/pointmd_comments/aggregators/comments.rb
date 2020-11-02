module PointmdComments
  module Aggregators
    class Comments
      def call(page)
        parse_comments(page)
      end

      private

      def parse_comments(page)
        comments = page.css('div#simpals-comments-list').children.first.children
        comments.map do |comment|
          comment.css('p').children.last.text

        rescue StandardError
          next
        end.compact
      end
    end
  end
end
