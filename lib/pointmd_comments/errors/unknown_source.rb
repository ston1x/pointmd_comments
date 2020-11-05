module PointmdComments
  module Errors
    class UnknownSource < StandardError
      attr_reader :message

      def initialize
        super

        @message = "Unknown source specified. Allowed sources are: #{Aggregators::Posts::ALLOWED_SOURCES}"
      end
    end
  end
end
