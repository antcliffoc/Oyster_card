class Card
  attr_reader :balance
  attr_reader :touched_in
  $DEFAULT_LIMIT = 90
  $MINIMUM_FARE = 1

  def initialize(limit = $DEFAULT_LIMIT)
    @balance = 0
    @limit = limit
    @touched_in = false
    @min = $MINIMUM_FARE
  end

  def top_up(value)
    raise "exceeds £#{$DEFAULT_LIMIT}" if @balance + value > @limit
    @balance += value
  end



  def touch_in
    raise "Insufficient funds" if @balance < @min
    @touched_in = true
  end

  def touch_out
    @touched_in = false
    deduct
  end

  def in_journey?
    @touched_in
  end
  
  private

  def deduct(value = @min)
    @balance -= value
  end
  
end
