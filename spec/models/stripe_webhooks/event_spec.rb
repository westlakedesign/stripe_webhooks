require 'rails_helper'

module StripeWebhooks
  RSpec.describe Event, type: :model do
    describe '#stripe_event' do
      it 'should return the event from the Stripe API' do
        mock_event = StripeMock.mock_webhook_event('customer.created')
        event = StripeWebhooks::Event.create(stripe_event_id: mock_event.id)
        expect(event.stripe_event).to be_a(Stripe::Event)
      end

      it 'should trigger a Stripe::InvalidRequestError error' do
        event = StripeWebhooks::Event.create(stripe_event_id: 'fail!')
        expect do
          event.stripe_event
        end.to raise_error(Stripe::InvalidRequestError)
      end

      it 'should log a warning if the event is too old' do
        mock_event = StripeMock.mock_webhook_event('customer.created')
        event = StripeWebhooks::Event.create(stripe_event_id: mock_event.id, created_at: 31.days.ago)
        expect(Rails.logger).to receive(:warn)
        event.stripe_event
      end
    end

    describe '#validate!' do
      it 'should mark the event as authentic and update the columns' do
        mock_event = StripeMock.mock_webhook_event('customer.created')
        event = StripeWebhooks::Event.create(stripe_event_id: mock_event.id)
        event.validate!
        expect(event.is_authentic).to eq(true)
        expect(event.is_processed).to eq(true)
      end

      it 'should mark the event as not authentic' do
        event = StripeWebhooks::Event.create(stripe_event_id: 'fail!')
        event.validate!
        expect(event.is_authentic).to eq(false)
        expect(event.is_processed).to eq(true)
      end
    end

    describe '#run_callbacks!' do
      it 'should run callbacks associated with the given event type' do
        mock_event = StripeMock.mock_webhook_event('customer.created')
        event = StripeWebhooks::Event.create(stripe_event_id: mock_event.id)
        event.validate!
        expect(StripeWebhooks::Callback).to receive(:run_callbacks_for).with(
          event.stripe_event_type,
          event.stripe_event
        )
        event.run_callbacks!
      end
    end
  end
end
