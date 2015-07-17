require 'rails_helper'

module StripeWebhooks
  RSpec.describe EventsController, type: :controller do

    routes { StripeWebhooks::Engine.routes }

    describe "POST #create" do

      it "should create the event" do
        get :create
        #expect(response).to have_http_status(:success)
      end

      it "should not create a duplicate event" do
        get :create
        #expect(response).to have_http_status(:success)
      end

      it "should queue an active job" do
        get :create
        #expect(response).to have_http_status(:success)
      end

      it "should return an error response" do
        get :create
        #expect(response).to have_http_status(:success)
      end
    end

  end
end
