require 'oystercard'

describe Oystercard do

  it 'oystercard has a balance of 0' do
    expect(subject.balance).to eq(0)
  end

  describe '#top_up' do
    it 'Card has top-up facility' do
      expect(subject).to respond_to(:top_up).with(1).argument
    end
    it 'User can add money to the card' do
      expect{subject.top_up(10)}.to change{subject.balance}.from(0).to(10)
    end
    it 'User cannot top up more than card maximum' do
      max_balance = Oystercard::MAXIMUM_BALANCE
      subject.top_up(max_balance)
      expect{subject.top_up(1)}.to raise_error("Warning: top-up amount will exceed maximum balance of £#{max_balance}")
    end

  end
end
