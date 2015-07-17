require 'rails_helper'

module StripeWebhooks
  RSpec.describe EventsController, type: :controller do

    routes { StripeWebhooks::Engine.routes }

    let(:customer_created){
      StripeMock.mock_webhook_payload('customer.created').to_json
    }

    describe "POST #create" do

      it "should create the event" do
        expect{
          post :create, customer_created
        }.to change(StripeWebhooks::Event, :count).by(1)
        expect(response).to have_http_status(:success)
      end

      it "should not create a duplicate event" do
        post :create, customer_created
        expect{
          post :create, customer_created
        }.to_not change(StripeWebhooks::Event, :count)
        expect(response).to have_http_status(:success)
      end

      it "should queue an active job" do
        expect{
          post :create, customer_created
        }.to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :length).by(1)
        expect(ActiveJob::Base.queue_adapter.enqueued_jobs.last[:job]).to eq(StripeWebhooks::ProcessorJob)
      end

      it "should return an 400 error when the JSON is poorly formed" do
        post :create, File.read(StripeWebhooks::Engine.root.join('spec', 'data', 'parse_error.json'))
        expect(response).to have_http_status(400)
      end

      it "should return a 422 error when the provided data is not valid" do
        post :create, File.read(StripeWebhooks::Engine.root.join('spec', 'data', 'invalid_data.json'))
        expect(response).to have_http_status(422)
      end
    end

  end
end
