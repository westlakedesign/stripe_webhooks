require 'rails_helper'

module StripeWebhooks
  RSpec.describe ProcessorJob, type: :job do
    
    describe '#perform' do
      it 'should validate the event and run callbacks' do
        mock_event = StripeMock.mock_webhook_event('customer.created')
        event = StripeWebhooks::Event.create(:stripe_event_id => mock_event.id)
        expect(event).to receive(:run_callbacks!)
        StripeWebhooks::ProcessorJob.new(event).perform_now
      end

      it 'should not run callbacks on an event that is not authentic' do
        event = StripeWebhooks::Event.create(:stripe_event_id => 'fail!')
        expect(event).to_not receive(:run_callbacks!)
        StripeWebhooks::ProcessorJob.perform_now(event)
      end

    end

  end
end
