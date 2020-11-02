require_relative 'lib/pointmd_comments/version'

Gem::Specification.new do |spec|
  spec.name          = "pointmd_comments"
  spec.version       = PointmdComments::VERSION
  spec.authors       = ["Nicolai Stoianov"]
  spec.email         = ["stoianovnk@gmail.com"]

  spec.summary       = "Point.md comments aggregator"
  spec.description   = "This gem lets you aggregate comments from point.md website into a csv file."
  spec.homepage      = "https://github.com/ston1x/pointmd-comments"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.5")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Specify development dependencies
  spec.add_development_dependency 'rubocop', '1.1.0'
  spec.add_development_dependency 'pry'

  # Specify runtime dependencies
  spec.add_dependency 'nokogiri', '~> 1.10'
  spec.add_dependency 'watir'
  spec.add_dependency 'watir-webdriver'
end
