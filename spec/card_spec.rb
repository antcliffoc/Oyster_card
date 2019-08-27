require 'card'

describe Card do
  it { is_expected.to respond_to(:balance)}

  describe '.top_up' do
    it 'increases the balance by value' do
      subject.top_up(5)
      expect(subject.balance).to eq 5
    end
  end
end
