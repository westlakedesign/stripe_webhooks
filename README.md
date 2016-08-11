# StripeWebhooks

StripeWebhooks is a Rails engine for dealing with data posted from [Stripe via Webhooks](https://stripe.com/docs/webhooks).

## Goals

1. Provide an endpoint for capturing POST data from Stripe
2. Verify authenticity of data by checking against the Stripe API
3. Run callbacks in response to desired events
4. Enable an app to "catch up" with missed events in the case of a server outage
5. Store as little Stripe data locally as possible

## Requirements

- [Stripe](https://rubygems.org/gems/stripe) 1.23 or higher
- Rails 4.2
- Ruby 2.2

## Installation

First, install and configure the [stripe](https://rubygems.org/gems/stripe) gem according to their instructions. Then:

1. Add the gem to your Gemfile

        gem 'stripe_webhooks'

2. Run bundle install
3. Copy the database migrations to your rails project

        bundle exec rake railties:install:migrations
        rake db:migrate

4. Mount the engine in your routes.rb file

        mount StripeWebhooks::Engine => "/stripe_webhooks"

5. Restart your application

## Configuration

Once the gem has been installed and configured, log in to your Stripe account and [configure the webhook](https://stripe.com/docs/webhooks#configuring-your-webhook-settings) with your application endpoint.

The `stripe_webhooks` gem will capture and process events using [ActiveJob](http://guides.rubyonrails.org/active_job_basics.html). The default behavior for ActiveJob is to run tasks immediately; It is strongly recommended that you configure a background queue instead. See the ActiveJob docs for a list of available queueing back ends.

## Callbacks

Create a callback object using the generator, which accepts a name argument followed by a list of stripe event types.

    rails g stripe_webhooks:callback Customer customer.created customer.updated customer.deleted

*See the [official documentation](https://stripe.com/docs/api/ruby#event_types) for a list of possible events.*

This will do a few things for you:

1. Appends an entry to `config/initializers/stripe_webhook_callbacks.rb`, and creates this file if it does not exist.
2. Creates a new callback object at `app/callbacks/NAME_callback.rb`

A callback is a simple ruby object with a `#run` method.

    class CustomerCallback < ApplicationCallback
      handles_events 'customer.created', 'customer.updated', 'customer.deleted'

      def run(event)
        # do useful stuff here!
      end

    end
