require_dependency 'stripe_webhooks/application_controller'

module StripeWebhooks
  class EventsController < ApplicationController
    protect_from_forgery except: :create

    def create
      begin
        raw_data = JSON.parse(request.body.read)
      rescue JSON::ParserError => e
        render plain: e.message, status: 400
        return
      end

      @event = StripeWebhooks::Event.find_or_initialize_by(stripe_event_id: raw_data['id'])
      @event.stripe_event_type = raw_data['type']
      @event.livemode = raw_data['livemode']
      @event.user_id = raw_data['user_id']

      if @event.save()
        StripeWebhooks::ProcessorJob.perform_later(@event)
        head :ok
      else
        render plain: @event.errors.full_messages.first, status: 422
      end
    end

  end
end
