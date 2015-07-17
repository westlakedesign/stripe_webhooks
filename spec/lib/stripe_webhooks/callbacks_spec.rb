require 'rails_helper'

module StripeWebhooks
  RSpec.describe Callbacks do

    describe '.register_callback' do
      it 'should append the label to the list of callbacks' do
        expect{
          StripeWebhooks.register_callback('hello_world')
        }.to change(StripeWebhooks.callbacks, :length).by(1)
        expect(StripeWebhooks.callbacks.last).to eq('hello_world')
      end
    end

  end
end
