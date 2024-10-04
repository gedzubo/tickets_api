require "rails_helper"

describe TicketOptionsController, type: :request do
  let(:json_response) do
    JSON.parse(response.body)
  end

  describe "POST /ticket_options/:id/purchases" do
    let(:ticket_option) { create(:ticket_option, allocation: 3) }

    context "when we have enough tickets to complete the purchase" do
      let(:params) do
        {
          user_id: "38f13ced-8148-4d95-b5f6-28bf66f1eadb",
          quantity: 3
        }
      end

      it "responds with ok status" do
        post ticket_option_purchases_path(ticket_option), params: params

        expect(response).to have_http_status :ok
      end
    end

    context "when we do not have enough tickets to complete the purchase" do
      let(:params) do
        {
          user_id: "38f13ced-8148-4d95-b5f6-28bf66f1eadb",
          quantity: 4
        }
      end

      it "responds with bad request status" do
        post ticket_option_purchases_path(ticket_option), params: params

        expect(response).to have_http_status :bad_request
      end

      it "returns correct error message" do
        post ticket_option_purchases_path(ticket_option), params: params

        expect(json_response["message"]).to eq("We don't have enough tickets to complete your purchase")
      end
    end

    context "when invalid quantity parameter is provided" do
      let(:params) do
        {
          user_id: "38f13ced-8148-4d95-b5f6-28bf66f1eadb",
          quantity: 0
        }
      end

      it "responds with bad request status" do
        post ticket_option_purchases_path(ticket_option), params: params

        expect(response).to have_http_status :bad_request
      end

      it "returns correct error message" do
        post ticket_option_purchases_path(ticket_option), params: params

        expect(json_response["message"]).to eq("Please provide quantity which is a number and greater than zero")
      end
    end
  end
end
