require 'optparse'
require 'pointmd_comments/version'

module PointmdComments
  class OptParser
    attr_reader :options

    def initialize
      @options = {}
    end

    # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    def parse
      OptionParser.new do |opts|
        opts.banner = 'Usage: pointmd_comments [options]'

        opts.on('-v', '--verbose', 'Show logs and backtraces') do |v|
          options[:verbose] = v
        end

        opts.on(
          '-sSOURCE',
          '--source=SOURCE',
          "A source to pull links from. Available sources are: #{Aggregators::Posts::ALLOWED_SOURCES}"
        ) do |s|
          options[:source] = s.to_sym
        end
        opts.on(
          '-o OUTPUT_PATH',
          '--output=OUTPUT_PATH',
          'A custom file path for the CSV.'
        ) do |p|
          options[:output] = p
        end
        opts.on('-V', '--version', 'Version') do
          puts PointmdComments::VERSION
          exit
        end
      end.parse!

      set_default_source unless options[:source] && options[:path]
      validate_source

      options
    end
    # rubocop:enable Metrics/MethodLength, Metrics/AbcSize

    private

    def set_default_source
      options[:source] = :news
    end

    def validate_source
      return if Aggregators::Posts::ALLOWED_SOURCES.include? options[:source]

      raise Errors::UnknownSource
    end
  end
end
