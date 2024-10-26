class Purchase < ApplicationRecord
  belongs_to :ticket_option
  belongs_to :user
end
