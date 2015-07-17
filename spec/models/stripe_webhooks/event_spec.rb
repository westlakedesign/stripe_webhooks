require 'rails_helper'

module StripeWebhooks
  RSpec.describe Event, type: :model do

    describe '#stripe_event' do
      it 'should return the event from the Stripe API'
      it 'should trigger a Stripe::InvalidRequestError error'
    end

    describe '#validate!' do
      it 'should mark the event as authentic and update the columns'
      it 'should mark the event as not authentic'
    end

    describe '#run_callbacks!' do
      it 'should run callbacks associated with the given event type'
    end

  end
end
