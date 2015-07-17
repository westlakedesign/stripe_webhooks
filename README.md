# StripeWebhooks

**NOTICE**: This project is in early development. As such, I don't recommend using it for anything serious just yet. You have been warned! 

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

## Usage

TODO: This project is in the early development phase. This section will be updated as soon as the dust starts to settle.
