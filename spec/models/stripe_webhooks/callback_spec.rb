require 'rails_helper'

module StripeWebhooks
  RSpec.describe Callback, type: :model do

    class ::CustomerCallback < StripeWebhooks::Callback
      handles_events 'customer.created', 'customer.updated'
      mattr_accessor :callback_has_ran
      mattr_accessor :run_count
      def run(event)
        self.run_count += 1
        self.callback_has_ran = true
      end
    end
    StripeWebhooks.register_callback('customer')

    # Reset the callback_has_ran flag for each test so we can tell if the callback was triggered
    before(:each) do
      CustomerCallback.run_count = 0
      CustomerCallback.callback_has_ran = false
    end

    describe '.run_callbacks_for' do
      it 'should run the callbacks' do
        event = StripeMock.mock_webhook_event('customer.created')
        StripeWebhooks::Callback.run_callbacks_for('customer.created', event)
        expect(CustomerCallback.callback_has_ran).to eq(true)
      end

      it 'should not run a callback that does not handle the requested event type' do
        event = StripeMock.mock_webhook_event('charge.succeeded')
        StripeWebhooks::Callback.run_callbacks_for('charge.succeeded', event)
        expect(CustomerCallback.callback_has_ran).to eq(false)
      end
    end

    describe '.handles_events' do
      it 'should store a reference to the event types' do
        expect(CustomerCallback.event_types).to eq(['customer.created', 'customer.updated'])
      end
    end

    describe '#label' do
      it 'should return a label string' do
        expect(CustomerCallback.new.label).to eq('customer')
      end
    end

    describe '#run_once' do
      it 'should run the callback' do
        callback = CustomerCallback.new()
        event = StripeMock.mock_webhook_event('customer.created')
        callback.run_once(event)
        expect(CustomerCallback.callback_has_ran).to eq(true)
      end

      it 'should not run the callback if it has been ran before' do
        callback = CustomerCallback.new()
        event = StripeMock.mock_webhook_event('customer.created')
        callback.run_once(event)
        expect{
          callback.run_once(event)
        }.to_not change(CustomerCallback, :run_count)
        expect(CustomerCallback.run_count).to eq(1)
      end
    end

    describe '#handles?' do
      it 'should return true' do
        callback = CustomerCallback.new()
        expect(callback.handles?('customer.created')).to eq(true)
      end

      it 'should return false' do
        callback = CustomerCallback.new()
        expect(callback.handles?('charge.succeeded')).to eq(false)
      end
    end

  end
end
