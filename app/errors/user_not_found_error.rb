class UserNotFoundError < StandardError
  def message
    "We couldn't find the user with provided ID"
  end
end
