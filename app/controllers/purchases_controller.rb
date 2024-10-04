class PurchasesController < ApplicationController
  before_action :set_ticket_option, only: %i[ create ]

  # POST /ticket_options/:ticket_option_id/purchases
  def create
    service = TicketAllocationService.new(
      ticket_option: @ticket_option,
      user_id: ticket_allocation_params[:user_id],
      quantity: ticket_allocation_params[:quantity]
    )

    if service.run
      render json: {}, status: :ok
    else
      render json: { message: service.error_message }, status: :bad_request
    end
  end

  private

  def set_ticket_option
    @ticket_option = TicketOption.find(params[:ticket_option_id])
  end

  def ticket_allocation_params
    params.permit(:quantity, :user_id)
  end
end
