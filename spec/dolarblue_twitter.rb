require 'spec_helper'

describe Dolarblue do
  let(:blue_tweet) do
    Twitter::Tweet.new({
      id: '309326405148233731',
      text: 'Dolar Paralelo: $7,82',
      created_at: DateTime.parse('2013-03-06T12:35:36-03:00'),
      screen_name: 'DolarBlue'
    })
  end
  let(:official_tweet) do
    Twitter::Tweet.new({
      id: '309289043722637312',
      text: '#Cotizacion cierre promedio parcial 06-03-13: #Dolar: 5.06 // #Euro: 6.71 // #Real: 2.74.',
      created_at: DateTime.parse('2013-03-06T10:07:08-03:00'),
      screen_name: 'cotizacionhoyar'
    })
  end

  before do
    Twitter::Client.stub_chain(:new, :last_tweet).with('DolarBlue').and_return(blue_tweet)
    Twitter::Client.stub_chain(:new, :last_tweet).with('cotizacionhoyar').and_return(official_tweet)
    # Notify.stub(:notify).and_return(true)
  end

  describe '#new' do
    it 'fails if argument is not a Config class' do
      expect { described_class.new(nil) }.to raise_error(ArgumentError)
    end

    it 'start as invalid right after creation' do
      expect(subject).not_to be_valid
    end

    it 'fails if you try to use it before is valid' do
      expect { subject.gap }.to raise_error
      expect { subject.gap_percent }.to raise_error
      expect { subject.output }.to raise_error
    end
  end

  context 'updated' do
    before do
      subject.update!
    end

    describe '#update!' do
      it 'becomes valid after calling update!' do
        expect(subject).to be_valid
      end
    end

    describe '#output' do
      it 'has an output with real values' do
        expect(subject.output).to match(/Blue/)
        expect(subject.output).to match(/Tarjeta/)
      end
    end

    describe 'gap values' do
      it 'has a valid gap card value' do
        expect(subject.gap_card).to be >= 0
      end

      it 'has a valid gap card % value' do
        expect(subject.gap_card_percent).to be >= 0
      end

      it 'has a valid gap official value' do
        expect(subject.gap_official).to be >= 0
      end

      it 'has a valid gap official % value' do
        expect(subject.gap_official_percent).to be >= 0
      end
    end
  end

  describe 'constants' do
    it 'should have a version number' do
      expect(Dolarblue::VERSION).to_not be_nil
    end
  end

  describe 'ClassMethods' do
    it 'has an get_output() class method to retrieve latest values' do
      expect(Dolarblue.get_output).to match(/Blue/)
      expect(Dolarblue.get_output).to match(/Tarjeta/)
    end
  end

end
