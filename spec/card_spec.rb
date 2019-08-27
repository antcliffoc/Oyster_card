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

    describe ".deduct" do
      it "deducts value from balance" do
        subject.top_up(10)
        subject.deduct(6)
        expect(subject.balance).to eq(4)
      end
    end

    describe ".touch_in" do
      it "sets card as touched_in" do
        subject.touch_in
        expect(subject.touched_in).to eq(true)
      end
    end

    describe ".touch_out" do
      it "sets card as touched_in" do
        subject.touch_in
        subject.touch_out
        expect(subject.touched_in).to eq(false)
      end
    end

    describe ".in_journey?" do
      context "when in journey" do
        before do
          subject.touch_in
        end
        it "returns true" do
          expect(subject).to be_in_journey
        end
      end
      context "when not in journey" do
        before do
          subject.touch_out
        end
        it "returns false" do
          expect(subject).not_to be_in_journey
        end
      end
    end


  end
