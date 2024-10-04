class InvalidQuantityError < StandardError
  def message
    "Please provide quantity which is a number and greater than zero"
  end
end
