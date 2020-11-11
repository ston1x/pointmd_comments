require 'nokogiri'
require 'open-uri'
require 'csv'
require 'watir'

require 'pointmd_comments/version'
require 'pointmd_comments/opt_parser'

require 'pointmd_comments/aggregators/main'
require 'pointmd_comments/aggregators/posts'
require 'pointmd_comments/aggregators/comments'

require 'pointmd_comments/errors/not_implemented'
require 'pointmd_comments/errors/unknown_source'

require 'pry'

module PointmdComments
  class Error < StandardError; end

  def self.collect
    args = ARGV.dup
    options = OptParser.new.parse
    Aggregators::Main.new(options).call
  rescue StandardError => e
    puts e.class, e.message
    puts e.backtrace if args.include? '-v'
  end
end
