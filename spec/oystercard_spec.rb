require 'oystercard'

describe Oystercard do
  let(:station) { double('station') }
  let(:exit_station) { double('exit station') }

  it 'oystercard has a balance of 0' do
    expect(subject.balance).to eq Oystercard::DEFAULT_BALANCE
  end

  describe '#top_up' do
    it 'Card has top-up facility' do
      expect(subject).to respond_to(:top_up).with(1).argument
    end
    it 'User can add money to the card' do
      expect{subject.top_up(10)}.to change{subject.balance}.by 10
    end
    it 'User cannot top up more than card maximum' do
      max_balance = Oystercard::MAXIMUM_BALANCE
      subject.top_up(max_balance)
      expect{subject.top_up(1)}.to raise_error("Warning: top-up amount will exceed maximum balance of £#{max_balance}")
    end
  end
  # private method - reference for .send syntax
  describe '#deduct' do
    it 'Card deducts cash from balance' do
      subject.top_up(10)
      expect { subject.send(:deduct, 10) }.to change{subject.balance}.by -10
    end
  end

  describe '#touch_in' do
    it 'Card responds to touch in' do
      subject.top_up(1)
      expect(subject).to respond_to(:touch_in)
    end

    context 'after touching in' do
      before { subject.top_up(1) }

      it 'In-journey is true' do
        subject.touch_in(station)
        expect(subject).to be_in_journey
      end

      it 'saves the entry station' do
        subject.touch_in(station)
        expect(subject.entry_station).to be station
      end
    end

    context 'when balance is below minimum' do
      it 'raises an error' do
        min_balance = Oystercard::MINIMUM_FARE
        expect{ subject.touch_in(station) }.to raise_error "Minimum balance required: £#{min_balance}"
      end
    end
  end

  describe '#touch_out' do
    it 'Card responds to touch out' do
      expect(subject).to respond_to(:touch_out)
    end

    context 'after touching out' do
      before { subject.top_up(1) }

      it 'In journey is false' do
        subject.touch_in(station)
        subject.touch_out(exit_station)
        expect(subject).to_not be_in_journey
      end

      it 'deducts fare from balance' do
        expect { subject.touch_out(exit_station) }.to change { subject.balance }.by(-1)
      end

      it 'resets entry_station to nil' do
        subject.touch_in(station); subject.touch_out(exit_station)
        expect(subject.entry_station).to be nil
      end

      it 'saves exit station' do
        subject.touch_in(station); subject.touch_out(exit_station)
        expect(subject.exit_station).to be exit_station
      end
    end
  end
end
