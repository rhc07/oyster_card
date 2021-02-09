class Oystercard
  attr_reader :balance

  DEFAULT_BALANCE = 0
  MINIMUM_BALANCE = 1
  MAXIMUM_BALANCE = 90

  def initialize
    @balance = DEFAULT_BALANCE
    @in_journey = false
  end

  def top_up(cash)
    fail "Warning: top-up amount will exceed maximum balance of £#{MAXIMUM_BALANCE}" if (@balance + cash) > MAXIMUM_BALANCE
    @balance += cash
  end

  def deduct(cash)
    @balance -= cash
  end

  def touch_in
    fail "Minimum balance required: £1" if balance < MINIMUM_BALANCE
    self.in_journey = true
  end

  def touch_out
    self.in_journey = false
  end

  def in_journey?
    in_journey
  end

  private
  attr_accessor :in_journey


end
