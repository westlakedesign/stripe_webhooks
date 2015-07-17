require 'rails_helper'

module StripeWebhooks
  RSpec.describe Callback, type: :model do
    
    describe '.run_callbacks_for' do
      it 'should run the callbacks'
      it 'should not run a callback that does not handle the requested event type'
      it 'should raise an error if the callback class does not exist'
    end

    describe '.handles_events' do
      it 'should store a reference to the event types'
    end

    describe '#label' do
      it 'should return a label string'
    end

    describe '#run_once' do
      it 'should run the callback'
      it 'should not run the callback if it has been ran before'
    end

    describe '#handles?' do
      it 'should return true'
      it 'should return false'
    end

  end
end
