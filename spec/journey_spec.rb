require 'journey'

describe Journey do
  subject { described_class.new('Kings Cross', 'Balham') }

  describe '#entry_station' do
    it 'returns the entry_station' do
      expect(subject.entry_station).to eq 'Kings Cross'
    end
  end
end
