class TicketOption < ApplicationRecord
  has_many :tickets, dependent: :destroy
  has_many :purchases, dependent: :destroy

  validates :name, presence: true
  validates :desc, presence: true
  validates :allocation, presence: true, numericality: { only_integer: true, greater_than: 0 }, on: :create
end
