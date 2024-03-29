require 'card'

describe Card do
  before do
    subject.top_up(1)
  end
  let(:station) { double(:station) }
  let(:station2) { double(:station) }


  it { is_expected.to respond_to(:balance)}
  it { is_expected.to respond_to(:journeys)}

  it "stores an array journeys" do
    expect(subject.journeys).to be_empty
  end

  describe '.top_up' do
    it 'increases the balance by value' do
      subject.top_up(5)
      expect(subject.balance).to eq 6
    end
      it 'Cant exceed top up limit' do
        expect{ subject.top_up($DEFAULT_LIMIT) }.to raise_error("exceeds £#{$DEFAULT_LIMIT}")
      end
    end

    describe ".touch_in" do
      it "sets card as touched_in" do
        subject.touch_in(station)
        expect(subject).to be_in_journey
      end

      it 'records the entry station' do
        subject.touch_in(station)
        expect(subject.entry_station).to eq(station)
      end

      context 'card balance is lower than minimum' do
        before do
          subject.touch_out(station2)
        end
        it "raises an error" do
          expect{subject.touch_in(station)}.to raise_error("Insufficient funds")
        end
      end
    end

    describe ".touch_out" do
      it "sets card as touched_in" do
        subject.touch_in(station)
        subject.touch_out(station2)
        expect(subject).not_to be_in_journey
      end

      it "deducts correct amount from card ($MINIMUM_FARE)" do
        expect{subject.touch_out(station2)}.to change{subject.balance}.by(-$MINIMUM_FARE)
      end
    end

    describe ".in_journey?" do
      context "when in journey" do
        before do
          subject.touch_in(station)
        end
        it "returns true" do
          expect(subject).to be_in_journey
        end
      end
      context "when not in journey" do
        before do
          subject.touch_out(station2)
        end
        it "returns false" do
          expect(subject).not_to be_in_journey
        end
      end
    end

    describe "saving one journey" do
      before do
        subject.touch_in(station)
        subject.touch_out(station2)
      end
      it "stores exit and entry stations for journey" do
        expect(subject.journeys).to include(entry: station, exit: station2)
      end
    end

  end
