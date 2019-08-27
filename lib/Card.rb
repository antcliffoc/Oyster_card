class Card
  attr_reader :balance
  attr_reader :touched_in
  $DEFAULT_LIMIT = 90

  def initialize(limit = $DEFAULT_LIMIT)
    @balance = 0
    @limit = limit
    @touched_in = false
  end

  def top_up(value)
    raise "exceeds £#{$DEFAULT_LIMIT}" if @balance + value > @limit
    @balance += value
  end

  def deduct(value)
    @balance -= value
  end

  def touch_in
    @touched_in = true
  end

  def touch_out
    @touched_in = false
  end

  def in_journey?
    @touched_in
  end
end
