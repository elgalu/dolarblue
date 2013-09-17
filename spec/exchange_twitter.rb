require 'spec_helper'

describe Dolarblue::Exchange do
  let(:screen_name) { 'DolarBlue' }
  let(:blue) { described_class.new('Blue', screen_name, /\$(\d+)[\.,](\d+)/, 0.99) }
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
    Twitter::Client.stub_chain(:new, :last_tweet).with(screen_name).and_return(blue_tweet)
  end

  describe '#new' do
    it 'fails if missing arguments' do
      expect { described_class.new(nil) }.to raise_error(ArgumentError)
    end

    it 'start as invalid right after creation' do
      expect(blue).to_not be_valid
    end
  end

  describe 'validation' do
    it 'fails if you try to use it before is valid' do
      expect { blue.buy_value }.to raise_error
      expect { blue.sell_value }.to raise_error
      expect { blue.updated_ago }.to raise_error
      expect { blue.output_values }.to raise_error
      expect { blue.output_link }.to raise_error
    end
  end

  context 'updated' do
    before do
      blue.update!
    end

    describe '#update!' do
      it 'becomes valid after calling update!' do
        expect(blue).to be_valid
      end
    end

    describe 'instance methods' do
      it 'has the correct name' do
        expect(blue.name).to eq('Blue')
      end

      it 'has a proper buy_value' do
        expect(blue.buy_value).to be > 0
      end

      it 'has a proper sell_value' do
        expect(blue.sell_value).to be > 0
      end

      it 'has a proper updated_at' do
        expect(blue.updated_at).to be_a(DateTime)
      end

      it 'has a proper updated_ago' do
        expect(blue.updated_ago).to be_a(String)
      end

      it 'has a source url' do
        expect(blue.source_url).to be_a(String)
      end

      it 'has a valid output values string' do
        expect(blue.output_values).to match(/Blue.*Updated/)
      end

      it 'has a valid output link string' do
        expect(blue.output_link).to match(/Blue.*http.*twitter/)
      end
    end
  end
end
