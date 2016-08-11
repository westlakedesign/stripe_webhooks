require 'rails_helper'

module StripeWebhooks
  RSpec.describe Callbacks do

    # We need to reset the callbacks array to its original state after this spec runs
    before(:all) do
      @callbacks_original = StripeWebhooks.callbacks
      StripeWebhooks.instance_variable_set(:@callbacks, [])
    end
    after(:all) do
      StripeWebhooks.instance_variable_set(:@callbacks, @callbacks_original)
    end

    describe '.register_callback' do
      it 'should append the label to the list of callbacks' do
        expect do
          StripeWebhooks.register_callback('some_callback')
        end.to change(StripeWebhooks.callbacks, :length).by(1)
        expect(StripeWebhooks.callbacks.last).to eq('some_callback')
      end
    end

  end
end
