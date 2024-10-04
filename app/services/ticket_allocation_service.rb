class TicketAllocationService
  def initialize(ticket_option:, quantity:, user_id:)
    @ticket_option = ticket_option
    @quantity = quantity.to_i
    @user_id = user_id
    @error_message = nil
  end

  def run
    validate_inputs
    ticket_option.with_lock do
      ticket_option.reload

      current_quantity = ticket_option.allocation
      raise NotEnoughTicketsAvailableError if current_quantity < quantity

      ticket_option.update!(allocation: current_quantity - quantity)
      purchase = Purchase.create!(quantity:, user_id:, ticket_option:)
      (1..quantity).each do
        Ticket.create(purchase_id: purchase.id, ticket_option: ticket_option)
      end
    end

    true
  rescue NotEnoughTicketsAvailableError, InvalidQuantityError => e
    @error_message = e.message
    error_message.nil?
  end

  attr_accessor :error_message

  private
  attr_reader :ticket_option, :quantity, :user_id

  def validate_inputs
    # in here I would check if the user ID is valid and if quantity is actually a valid number and not a zero
    raise InvalidQuantityError if quantity.zero? || quantity < 0
  end
end
