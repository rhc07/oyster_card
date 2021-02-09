class Oystercard
  attr_reader :balance, :entry_station

  DEFAULT_BALANCE = 0
  MINIMUM_FARE = 1
  MAXIMUM_BALANCE = 90

  def initialize
    @balance = DEFAULT_BALANCE
    @in_journey = false
    @entry_station = nil
  end

  def top_up(cash)
    fail "Warning: top-up amount will exceed maximum balance of £#{MAXIMUM_BALANCE}" if (@balance + cash) > MAXIMUM_BALANCE
    self.balance += cash
  end

  def touch_in(station)
    fail "Minimum balance required: £1" if balance < MINIMUM_FARE
    self.entry_station = station
    self.in_journey = true
  end

  def touch_out
    self.balance -= MINIMUM_FARE
    self.entry_station = nil
    self.in_journey = false
  end

  def in_journey?
    in_journey
  end

  private

  attr_writer :balance, :entry_station
  attr_accessor :in_journey

  def deduct(cash)
    self.balance -= cash
  end
end
