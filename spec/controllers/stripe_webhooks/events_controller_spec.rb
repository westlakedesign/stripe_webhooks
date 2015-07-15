require 'rails_helper'

module StripeWebhooks
  RSpec.describe EventsController, type: :controller do

    describe "GET #create" do
      it "returns http success" do
        get :create
        expect(response).to have_http_status(:success)
      end
    end

  end
end
