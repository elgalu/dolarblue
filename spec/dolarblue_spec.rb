require 'spec_helper'

vcr_options = { allow_playback_repeats: true }

describe Dolarblue, vcr: vcr_options do
  context 'Class Methods' do
    subject { Dolarblue }

    it 'should return all the dollar exchange Blue/Official/Card values and percentiles suitable for user printing' do
      # expect(subject.get_output).to match(/Dollar Blue.*\d+\.\d+.*^Information source/)
      expect(subject.get_output).to match(/Obtaining/)
      expect(subject.get_output).to match(/Done/)
      values = %q{\d+\.\d+\s+\/\s+\d+\.\d+}
      expect(subject.get_output).to match(/Official.*#{values}/)
      expect(subject.get_output).to match(/Card.*n\/a\s+\/\s+\d+\.\d+/)
      expect(subject.get_output).to match(/Blue.*#{values}/)
      expect(subject.get_output).to match(/Gap card/)
      expect(subject.get_output).to match(/Gap official/)
      expect(subject.get_output).to match(/Information source/)
    end
  end
end
