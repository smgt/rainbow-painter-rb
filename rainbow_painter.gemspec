lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rainbow_painter/version'

Gem::Specification.new do |spec|
  spec.name          = 'rainbow_painter'
  spec.version       = RainbowPainter::VERSION
  spec.authors       = ['Simon Gate']
  spec.email         = ['simon@smgt.me']

  spec.summary       = 'Write a short summary, because RubyGems requires one.'
  spec.description   = 'Write a longer description or delete this line.'
  spec.homepage      = 'http://sunet.se'
  spec.license       = 'MIT'

  spec.required_ruby_version = '> 2.5.0'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.17'
  spec.add_development_dependency 'jsonlint', '~> 0.3'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'minitest-reporters'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake', '>= 12.3.3'
  spec.add_development_dependency 'reek', '~> 6.0.0'
  spec.add_development_dependency 'rubocop', '~> 1.8.0'
  spec.add_development_dependency 'rubocop-minitest', '~> 0.10.0'
  spec.add_development_dependency 'rubocop-performance', '~> 1.9.0'
  spec.add_development_dependency 'simplecov', '~> 0.17.0'
end
