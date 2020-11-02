require 'nokogiri'
require 'open-uri'
require 'csv'
require 'watir'

require 'pointmd_comments/version'
require 'pointmd_comments/aggregators/main'
require 'pointmd_comments/aggregators/posts'
require 'pointmd_comments/aggregators/comments'
require 'pointmd_comments/errors/not_implemented'

module PointmdComments
  class Error < StandardError; end

  def self.collect
    # TODO: Implement some parent/main/base class for orchestration
  end
end
