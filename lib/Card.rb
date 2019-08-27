class Card
  attr_reader :balance
  attr_reader :touched_in
  attr_reader :entry_station
  attr_reader :journeys

  $DEFAULT_LIMIT = 90
  $MINIMUM_FARE = 1

  def initialize(limit = $DEFAULT_LIMIT)
    @balance = 0
    @limit = limit
    @min = $MINIMUM_FARE
    @entry_station = nil
    @journeys = []
  end

  def top_up(value)
    raise "exceeds £#{$DEFAULT_LIMIT}" if @balance + value > @limit
    @balance += value
  end



  def touch_in(station)
    raise "Insufficient funds" if @balance < @min
    @entry_station = station
  end

  def touch_out(exit_station)
    @journeys << {entry: @entry_station, exit: exit_station}
    @entry_station = nil
    deduct
  end

  def in_journey?
    @entry_station != nil
  end

  private

  def deduct(value = @min)
    @balance -= value
  end

end
