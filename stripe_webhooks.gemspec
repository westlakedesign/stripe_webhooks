$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'stripe_webhooks/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'stripe_webhooks'
  s.version     = StripeWebhooks::VERSION
  s.authors     = ['Moser Consulting']
  s.email       = ['greg.woods@moserit.com']
  s.homepage    = 'https://github.com/westlakedesign/stripe_webhooks'
  s.summary     = 'Stripe Webhook event capture and processing engine.'
  s.description = 'Provides an endpoint for captring data posted via Webhooks in Stripe,
                  and a system for running callbacks in response to desired event types.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['spec/**/*'].reject { |f| f.match(%r{^spec\/dummy\/(log|tmp)}) }

  s.add_dependency 'rails', '>= 4.0'
  s.add_dependency 'stripe', '>= 1.18.0'

  s.add_development_dependency 'mysql2'
  s.add_development_dependency 'rspec-rails', '~> 3.5.0'
  s.add_development_dependency 'factory_girl_rails', '~> 4.8.0'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'stripe-ruby-mock'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'codeclimate-test-reporter'
end
