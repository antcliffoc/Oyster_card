require 'card'

describe Card do
  it { is_expected.to respond_to(:balance)}

  describe '.top_up' do
    it 'increases the balance by value' do
      subject.top_up(5)
      expect(subject.balance).to eq 5
    end
      it 'Cant exceed top up limit' do
        expect{ subject.top_up(91) }.to raise_error("exceeds £#{$DEFAULT_LIMIT}")
      end
    end
  end
