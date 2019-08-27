class Card
  attr_reader :balance
  $DEFAULT_LIMIT = 90
  def initialize(limit = $DEFAULT_LIMIT)
    @balance = 0
    @limit = limit
  end
  def top_up(value)
    raise "exceeds £#{$DEFAULT_LIMIT}" if @balance + value > @limit
    @balance += value
    end
end
