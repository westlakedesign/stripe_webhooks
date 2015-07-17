require 'rails_helper'

module StripeWebhooks
  RSpec.describe ProcessorJob, type: :job do
    
    describe '#perform' do
      it 'should validate the event and run callbacks'
      it 'should not run callbacks on an event that is not authentic'
    end

  end
end
