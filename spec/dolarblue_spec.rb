require 'spec_helper'

CLI_MATCHERS = [
  /^Obtaining latest/,
  /Parsing values/,
  /^Done: \d+/
]

values = %q{\d+\.\d+\s+\/\s+\d+\.\d+}
start  = '- '
OUTPUT_MATCHERS = [
  /^#{start}Dollar Official.*#{values}$/,
  /^#{start}Dollar Bolsa.*n\/a\s+\/\s+\d+\.\d+$/,
  /^#{start}Dollar Blue.*#{values}$/,
  /^#{start}Gap bolsa/,
  /^#{start}Gap official/,
  /^Information source:$/
]

describe Dolarblue do
  before(:each) do
    # Save and capture standard output
    @saved_stdout = $stdout
    $stdout = StringIO.new
  end

  after(:each) do
    # Restore standard output
    $stdout = @saved_stdout
  end

  context 'CLI' do
    let(:path) { File.expand_path('../../bin/dolarblue', __FILE__) }

    it 'should print out status information about querying base_url and parsing data' do
      (CLI_MATCHERS).each do |regex|
        expect($stdout).to receive(:print).with(regex)
      end
      load path
    end

    it 'should puts all the dollar exchange values' do
      load path
      (OUTPUT_MATCHERS).each do |regex|
        expect($stdout.string).to match(regex)
      end
    end
  end

  context 'Class Methods' do
    subject { Dolarblue }

    it 'should return all the dollar exchange Blue/Official/Bolsa values and percentiles' do
      OUTPUT_MATCHERS.each do |regex|
        expect(subject.get_output).to match(regex)
      end
    end
  end

end
