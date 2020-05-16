# frozen_string_literal: true

require_relative 'lib/justdi/version'

Gem::Specification.new do |spec|
  spec.name    = 'justdi'
  spec.version = Justdi::VERSION
  spec.authors = ['Dmitry Ruban']
  spec.email   = ['dkruban@gmail.com']

  spec.summary     = 'The simple DI container'
  spec.description = 'The simple DI container'
  spec.homepage    = 'https://github.com/RuBAN-GT/justdi'
  spec.license     = 'MIT'

  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
end
