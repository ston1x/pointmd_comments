require_relative 'lib/pointmd_comments/version'

Gem::Specification.new do |spec|
  spec.name          = 'pointmd_comments'
  spec.version       = PointmdComments::VERSION
  spec.authors       = ['Nicolai Stoianov']
  spec.email         = ['stoianovnk@gmail.com']

  spec.summary       = 'Point.md comments aggregator'
  spec.description   = 'This gem lets you aggregate comments from point.md website into a csv file.'
  spec.homepage      = 'https://github.com/ston1x/pointmd-comments'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.5')

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage

  spec.files         = Dir['lib/**/*.rb']
  spec.bindir        = 'bin'
  spec.executables   = ['pointmd_comments']
  spec.require_paths = ['lib']

  # Specify development dependencies
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rubocop', '1.1.0'

  # Specify runtime dependencies
  spec.add_dependency 'nokogiri', '~> 1.10'
  spec.add_dependency 'watir'
  spec.add_dependency 'watir-webdriver'
end
