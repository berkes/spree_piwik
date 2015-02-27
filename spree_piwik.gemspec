# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_piwik'
  s.version     = '1.0.0-alpha1'
  s.summary     = 'Adds piwik tracking with Ecommerce tracking'
  s.description = File.read(File.join(File.dirname(__FILE__), 'README.md'))
  s.required_ruby_version = '>= 1.9.3'

  s.author    = 'Bèr Kessels'
  s.email     = 'ber@berk.es'
  s.homepage  = 'http://berk.es'
  s.license   = 'BSD-3'

  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '~> 2.3'

  s.add_development_dependency 'therubyracer', '~> 0.12'
  s.add_development_dependency 'capybara', '~> 2.4'
  s.add_development_dependency 'coffee-rails', '~> 4.1'
  s.add_development_dependency 'database_cleaner', '~> 1.4'
  s.add_development_dependency 'factory_girl', '~> 4.5'
  s.add_development_dependency 'ffaker', '~> 1'
  s.add_development_dependency 'rspec-rails',  '~> 3.1'
  s.add_development_dependency 'spring-commands-rspec', '~> 1'
  s.add_development_dependency 'rkelly-remix', '~> 0'
  s.add_development_dependency 'launchy', '~> 2.4'
  s.add_development_dependency 'sass-rails', '~> 4.0'
  s.add_development_dependency 'selenium-webdriver', '~> 2.44'
  s.add_development_dependency 'simplecov', '~> 0'
  s.add_development_dependency 'sqlite3', '~> 1.3'
end
