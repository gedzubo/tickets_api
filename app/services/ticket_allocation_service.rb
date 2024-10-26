class TicketAllocationService
  def initialize(ticket_option:, quantity:, user_id:)
    @ticket_option = ticket_option
    @quantity = quantity.to_i
    @user = User.find_by(id: user_id)
  end

  def run
    validate_inputs
    ticket_option.with_lock do
      ticket_option.reload

      current_quantity = ticket_option.allocation
      raise NotEnoughTicketsAvailableError if current_quantity < quantity

      ticket_option.update!(allocation: current_quantity - quantity)
      purchase = Purchase.create!(quantity:, user:, ticket_option:)
      (1..quantity).each { Ticket.create(purchase_id: purchase.id, ticket_option: ticket_option) }
    end

    [ true, nil ]
  rescue NotEnoughTicketsAvailableError, InvalidQuantityError, UserNotFoundError => e
    [ false, e.message ]
  end

  private
  attr_reader :ticket_option, :quantity, :user

  def validate_inputs
    raise UserNotFoundError if user.nil?
    raise InvalidQuantityError if quantity.zero? || quantity < 0
  end
end
