# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'better_attrs/version'

Gem::Specification.new do |gem|
  gem.name = 'better_attrs'
  gem.version = BetterAttrs::VERSION
  gem.authors = ['Jonathan W. Zaleski']
  gem.email = ['JonathanZaleski@gmail.com']
  gem.summary = 'Enhances `attr_accessor` and `attr_writer` to allow the specification of a callback to be invoked when an attribute value is changed.'
  gem.description = "#{gem.summary} Ideal for cascading updates or deployment scenarios where it is necessary to keep legacy values in sync until a time that they can be safely removed."
  gem.homepage = 'https://github.com/jzaleski/better_attrs'
  gem.license = 'MIT'

  gem.files = `git ls-files`.split($/)
  gem.executables = gem.files.grep(%r{^bin/}) { |file| File.basename(file) }
  gem.test_files = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency 'bundler', '~> 1.0'
  gem.add_development_dependency 'pry', '~> 0.10'
  gem.add_development_dependency 'rake', '~> 10.4'
  gem.add_development_dependency 'rspec', '~> 3.1'
end
