class NotEnoughTicketsAvailableError < StandardError
  def message
    "We don't have enough tickets to complete your purchase"
  end
end
