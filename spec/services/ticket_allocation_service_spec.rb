require "rails_helper"

RSpec.describe TicketAllocationService do
  describe "#run" do
    subject { described_class.new(ticket_option:, quantity:, user_id:) }

    let(:ticket_option) { create(:ticket_option, allocation: allocation) }
    let(:allocation) { 3 }
    let(:quantity) { 2 }
    let(:user) { create(:user) }
    let(:user_id) { user.id }

    context "with valid params" do
      it "returns correct response" do
        expect(subject.run).to eq([ true, nil ])
      end

      it "updates allocation number on the ticket option" do
        expect {
          subject.run
        }.to change(ticket_option, :allocation).from(3).to(1)
      end

      it "creates a purchase" do
        expect {
          subject.run
        }.to change(Purchase, :count).from(0).to(1)
      end

      it "allocates available tickets" do
        expect {
          subject.run
        }.to change(Ticket, :count).from(0).to(2)
      end
    end

    context "when we don't have enough tickets to fulfill the order" do
      let(:quantity) { 4 }

      let(:error_message) { "We don't have enough tickets to complete your purchase" }

      it "does not allocate the tickets" do
        expect {
          subject.run
        }.to_not change(ticket_option, :allocation)
      end

      it "returns correct response" do
        expect(subject.run).to eq([ false, error_message ])
      end
    end

    context "when invalid quantity is provided" do
      let(:quantity) { -1 }

      let(:error_message) { "Please provide quantity which is a number and greater than zero" }

      it "does not allocate the tickets" do
        expect {
          subject.run
        }.to_not change(ticket_option, :allocation)
      end

      it "returns correct response" do
        expect(subject.run).to eq([ false, error_message ])
      end
    end

    context "when user does not exist" do
      let(:user_id) { Faker::Internet.uuid }

      let(:error_message) { "We couldn't find the user with provided ID" }

      it "does not allocate the tickets" do
        expect {
          subject.run
        }.to_not change(ticket_option, :allocation)
      end

      it "returns correct response" do
        expect(subject.run).to eq([ false, error_message ])
      end
    end
  end
end
