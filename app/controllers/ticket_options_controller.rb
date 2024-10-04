class TicketOptionsController < ApplicationController
  before_action :set_ticket_option, only: %i[ show ]

  # GET /ticket_options/1
  def show
    render json: TicketOptionPresenter.new(@ticket_option)
  end

  # POST /ticket_options
  def create
    @ticket_option = TicketOption.new(ticket_option_params)

    if @ticket_option.save
      render json: TicketOptionPresenter.new(@ticket_option), status: :created, location: @ticket_option
    else
      render json: @ticket_option.errors, status: :unprocessable_entity
    end
  end

  private

  def set_ticket_option
    @ticket_option = TicketOption.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def ticket_option_params
    params.permit(:name, :desc, :allocation)
  end
end
