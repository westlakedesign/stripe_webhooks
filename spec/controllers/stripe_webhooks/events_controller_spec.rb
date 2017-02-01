require 'rails_helper'

module StripeWebhooks
  RSpec.describe EventsController, type: :controller do
    routes { StripeWebhooks::Engine.routes }

    let(:customer_created) do
      StripeMock.mock_webhook_payload('customer.created').to_json
    end

    describe 'POST #create' do
      it 'should create the event' do
        expect do
          post :create, body: customer_created, format: :json
        end.to change(StripeWebhooks::Event, :count).by(1)
        expect(response).to have_http_status(:success)
      end

      it 'should not create a duplicate event' do
        post :create, body: customer_created, format: :json
        expect do
          post :create, body: customer_created, format: :json
        end.to_not change(StripeWebhooks::Event, :count)
        expect(response).to have_http_status(:success)
      end

      it 'should queue an active job' do
        expect do
          post :create, body: customer_created, format: :json
        end.to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :length).by(1)
        expect(ActiveJob::Base.queue_adapter.enqueued_jobs.last[:job]).to eq(StripeWebhooks::ProcessorJob)
      end

      it 'should return an 400 error when the JSON is poorly formed' do
        post :create,
          body: File.read(StripeWebhooks::Engine.root.join('spec', 'data', 'parse_error.json')),
          format: :json
        expect(response).to have_http_status(400)
      end

      it 'should return a 422 error when the provided data is not valid' do
        post :create,
          body: File.read(StripeWebhooks::Engine.root.join('spec', 'data', 'invalid_data.json')),
          format: :json
        expect(response).to have_http_status(422)
      end
    end
  end
end
