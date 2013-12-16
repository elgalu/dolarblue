require 'spec_helper'

describe Dolarblue do

  context 'Class Methods' do
    subject { Dolarblue }

    it 'should return all the dollar exchange Blue/Official/Card values and percentiles suitable for user printing' do
      expect(subject.get_output).to match(/Obtaining/)
      expect(subject.get_output).to match(/Done/)
      values = %q{\d+\.\d+\s+\/\s+\d+\.\d+}
      start  = '- '
      expect(subject.get_output).to match(/^#{start}Dollar Official.*#{values}$/)
      expect(subject.get_output).to match(/^#{start}Dollar Card.*n\/a\s+\/\s+\d+\.\d+$/)
      expect(subject.get_output).to match(/^#{start}Dollar Blue.*#{values}$/)
      expect(subject.get_output).to match(/^#{start}Gap card/)
      expect(subject.get_output).to match(/^#{start}Gap official/)
      expect(subject.get_output).to match(/^Information source:$/)
    end
  end

end
