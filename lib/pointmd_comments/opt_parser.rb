require 'optparse'
require 'pointmd_comments/version'

module PointmdComments
  class OptParser
    attr_reader :options

    def initialize
      @options = {}
    end

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
          '-p PATH',
          '--path=PATH',
          'A file path to pull links from.'
        ) do |s|
          options[:source] = s.to_sym
        end
        opts.on('-V', '--version', 'Version') do
          puts PointmdComments::VERSION
          exit
        end
      end.parse!

      set_default_source if options[:source].empty? && options[:path].empty?
      validate_source

      options
    end

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
