require 'spec_helper'

describe Dolarblue::Exchange do
  let(:screen_name) { 'DolarBlue' }
  let(:blue) { described_class.new(name: 'Blue', screen_name: screen_name, regexp: /\$(\d+)[\.,](\d+)/, buy_sell_factor: 0.99) }
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
      blue.should_not be_valid
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
        blue.should be_valid
      end
    end

    describe 'instance methods' do
      it 'has the correct name' do
        blue.name.should == 'Blue'
      end

      it 'has a proper buy_value' do
        blue.buy_value.should be > 0
      end

      it 'has a proper sell_value' do
        blue.sell_value.should be > 0
      end

      it 'has a proper updated_at' do
        blue.updated_at.should be_a(DateTime)
      end

      it 'has a proper updated_ago' do
        blue.updated_ago.should be_a(String)
      end

      it 'has a source url' do
        blue.source_url.should be_a(String)
      end

      it 'has a valid output values string' do
        blue.output_values.should match(/Blue.*Updated/)
      end

      it 'has a valid output link string' do
        blue.output_link.should match(/Blue.*http.*twitter/)
      end
    end
  end
end
