class TicketOptionPresenter
  def initialize(object)
    @object = object
  end

  delegate :id, :name, :desc, :allocation, to: :object

  def as_json(*)
    {
      id:,
      name:,
      desc:,
      allocation:
    }
  end

  private
  attr_reader :object
end
