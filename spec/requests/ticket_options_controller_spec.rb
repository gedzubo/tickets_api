require "rails_helper"

describe TicketOptionsController, type: :request do
  let(:json_response) do
    JSON.parse(response.body)
  end

  describe "POST /ticket_options" do
    context "with valid params" do
      let(:params) do
        {
          name: "Test Event",
          desc: "Test Event Description",
          allocation: 10
        }
      end

      it "responds with created status" do
        post ticket_options_path, params: params

        expect(response).to have_http_status :created
      end

      it "returns correct response body" do
        post ticket_options_path, params: params

        expect(json_response["name"]).to eq("Test Event")
        expect(json_response["desc"]).to eq("Test Event Description")
        expect(json_response["allocation"]).to eq(10)
      end
    end

    context "with invalid params" do
      let(:params) do
        {
          name: "Test Event",
          desc: "Test Event Description",
          allocation: 0
        }
      end

      it "responds with unprocessable entity status" do
        post ticket_options_path, params: params

        expect(response).to have_http_status :unprocessable_content
      end
    end
  end

  describe "GET /ticket_options/:id" do
    let(:ticket_option) { create(:ticket_option) }

    it "responds with created status" do
      get ticket_option_path(ticket_option)

      expect(response).to have_http_status :ok
    end

    it "returns correct response body" do
      get ticket_option_path(ticket_option)

      expect(json_response["id"]).to eq(ticket_option.id)
      expect(json_response["name"]).to eq(ticket_option.name)
      expect(json_response["desc"]).to eq(ticket_option.desc)
      expect(json_response["allocation"]).to eq(ticket_option.allocation)
    end
  end
end
