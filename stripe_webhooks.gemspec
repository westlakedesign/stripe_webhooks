$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "stripe_webhooks/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "stripe_webhooks"
  s.version     = StripeWebhooks::VERSION
  s.authors     = ["Westlake Interactive"]
  s.email       = ["greg@westlakedesign.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of StripeWebhooks."
  s.description = "TODO: Description of StripeWebhooks."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.3"

  s.add_development_dependency "mysql2"
end
