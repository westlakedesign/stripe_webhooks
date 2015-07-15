require_dependency "stripe_webhooks/application_controller"

module StripeWebhooks
  class EventsController < ApplicationController
    protect_from_forgery :except => :create

    def create
      begin
        raw_data = JSON.parse(request.body.read)
      rescue JSON::ParserError => e
        render :text => e.message, :status => 400
        return
      end

      event = StripeWebhooks::Event.find_or_initialize_by(:stripe_event_id => raw_data['id'])

      if event.save()
        render :nothing => true, :status => 200
      else
        render :text => event.errors.full_messages.first, :status => 422
      end
    end

  end
end
