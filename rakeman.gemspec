# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'rakeman/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name          = 'rakeman'
  spec.version       = Rakeman::VERSION
  spec.authors       = %w[CaptainJNS olehvolynets YaroslavZahoruiko]
  spec.email         = %w[sereda9623@gmail.com]

  spec.summary       = 'This gem allow to manage your project rake tasks.'
  spec.homepage      = 'https://github.com/CaptainJNS/rakeman'
  spec.license       = 'MIT'

  spec.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  spec.add_dependency 'rails', '>= 5.1.5'
  spec.add_dependency 'sass-rails'

  # Database
  spec.add_development_dependency 'pg', '~> 1.2', '>= 1.2.3'

  # Tests
  spec.add_development_dependency 'rspec-rails', '~> 4.0', '>= 4.0.1'

  # Linters
  spec.add_development_dependency 'capybara', '~> 3.32', '>= 3.32.1'
  spec.add_development_dependency 'factory_bot_rails', '~> 5.1', '>= 5.1.1'
  spec.add_development_dependency 'faker', '~> 2.11'
  spec.add_development_dependency 'pry-rails', '~> 0.3.9'
  spec.add_development_dependency 'rubocop', '~> 1.2'
  spec.add_development_dependency 'rubocop-rails', '~> 2.8', '>= 2.8.1'
  spec.add_development_dependency 'rubocop-rspec', '~> 2.0'
  spec.add_development_dependency 'selenium-webdriver', '~> 3.142', '>= 3.142.7'
  spec.add_development_dependency 'shoulda-matchers', '~> 4.3'

  # HTML preprocessors
  spec.add_development_dependency 'haml', '~> 5.1', '>= 5.1.1'
  spec.add_development_dependency 'haml-rails', '~> 2.0', '>= 2.0.1'
end
