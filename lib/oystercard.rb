class Oystercard
  attr_reader :balance, :entry_station, :exit_station, :journey_history

  DEFAULT_BALANCE = 0
  MINIMUM_FARE = 1
  MAXIMUM_BALANCE = 90

  def initialize
    @balance = DEFAULT_BALANCE
    @entry_station = nil
    @exit_station = nil
    @journey_history = []
  end

  def top_up(cash)
    fail "Warning: top-up amount will exceed maximum balance of £#{MAXIMUM_BALANCE}" if (@balance + cash) > MAXIMUM_BALANCE
    self.balance += cash
  end

  def touch_in(station)
    fail "Minimum balance required: £1" if balance < MINIMUM_FARE
    self.entry_station = station
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    self.exit_station = station
    @journey_history << {entry: entry_station, exit: exit_station}
    self.entry_station = nil
  end

  def in_journey?
    !!entry_station
  end

  private

  attr_writer :balance, :entry_station, :exit_station

  def deduct(cash)
    self.balance -= cash
  end
end
