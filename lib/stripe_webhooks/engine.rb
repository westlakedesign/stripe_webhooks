module StripeWebhooks
  class Engine < ::Rails::Engine
    isolate_namespace StripeWebhooks
    config.autoload_paths << "#{root}/lib"

    config.generators do |g|
      g.test_framework :rspec, :fixture => false
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
      g.assets false
      g.helper true
    end

  end
end
